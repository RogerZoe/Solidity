// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract MultiSigWallet {
    // Events to emit during various actions in the contract.
    // `Deposit` is emitted when Ether is sent to the contract.
    event Deposit(address indexed sender, uint256 amount, uint256 balance);
    
    // `SubmitTransaction` is emitted when a new transaction is proposed by an owner.
    event SubmitTransaction(
        address indexed owner,   // Owner who submitted the transaction
        uint256 indexed txIndex, // Transaction index
        address indexed to,      // Address to send Ether to
        uint256 value,           // Amount of Ether to send
        bytes data               // Data to execute with the transaction
    );
    
    // `ConfirmTransaction` is emitted when an owner confirms a proposed transaction.
    event ConfirmTransaction(address indexed owner, uint256 indexed txIndex);
    
    // `RevokeConfirmation` is emitted when an owner revokes their confirmation.
    event RevokeConfirmation(address indexed owner, uint256 indexed txIndex);
    
    // `ExecuteTransaction` is emitted when the required number of confirmations are reached, and the transaction is executed.
    event ExecuteTransaction(address indexed owner, uint256 indexed txIndex);

    // Array to store the addresses of all the owners of the wallet.
    address[] public owners;
    
    // Mapping to track whether an address is an owner.
    mapping(address => bool) public isOwner;
    
    // Number of confirmations required before a transaction can be executed.
    uint256 public numConfirmationsRequired;

    // Struct to represent each transaction submitted for execution.
    struct Transaction {
        address to;              // Address of the recipient
        uint256 value;           // Amount of Ether to transfer
        bytes data;              // Data payload (if any) to be sent with the transaction
        bool executed;           // Boolean to track whether the transaction has been executed
        uint256 numConfirmations; // Number of confirmations the transaction has received
    }

    // Mapping to check if a transaction is confirmed by a specific owner.
    // First key is the transaction index, and second key is the owner address.
    mapping(uint256 => mapping(address => bool)) public isConfirmed;

    // Array of all transactions that have been submitted.
    Transaction[] public transactions;

    // Modifier to restrict access to only wallet owners.
    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }

    // Modifier to check if the transaction exists.
    modifier txExists(uint256 _txIndex) {
        require(_txIndex < transactions.length, "tx does not exist");
        _;
    }

    // Modifier to ensure the transaction hasn't been executed yet.
    modifier notExecuted(uint256 _txIndex) {
        require(!transactions[_txIndex].executed, "tx already executed");
        _;
    }

    // Modifier to check that the transaction has not been confirmed by the sender.
    modifier notConfirmed(uint256 _txIndex) {
        require(!isConfirmed[_txIndex][msg.sender], "tx already confirmed");
        _;
    }

    // Constructor to initialize the wallet with owners and the required number of confirmations.
    constructor(address[] memory _owners, uint256 _numConfirmationsRequired) {
        // Ensure there is at least one owner.
        require(_owners.length > 0, "owners required");
        
        // Ensure the required confirmations are valid.
        require(
            _numConfirmationsRequired > 0
                && _numConfirmationsRequired <= _owners.length,
            "invalid number of required confirmations"
        );

        // Add each owner to the `owners` array and mark them as owners in `isOwner` mapping.
        for (uint256 i = 0; i < _owners.length; i++) {
            address owner = _owners[i];

            // Ensure the owner's address is valid and unique.
            require(owner != address(0), "invalid owner");
            require(!isOwner[owner], "owner not unique");

            isOwner[owner] = true;
            owners.push(owner);
        }

        // Set the required number of confirmations.
        numConfirmationsRequired = _numConfirmationsRequired;
    }

    // Fallback function to accept Ether deposits to the wallet.
    receive() external payable {
        emit Deposit(msg.sender, msg.value, address(this).balance);
    }

    // Function to submit a new transaction.
    // Can only be called by an owner.
    function submitTransaction(address _to, uint256 _value, bytes memory _data)
        public
        onlyOwner
    {
        uint256 txIndex = transactions.length;

        // Add the transaction to the transactions array.
        transactions.push(
            Transaction({
                to: _to,               // Recipient of the transaction
                value: _value,         // Amount of Ether to transfer
                data: _data,           // Optional data to execute with the transaction
                executed: false,       // Initially, the transaction is not executed
                numConfirmations: 0    // Initially, there are no confirmations
            })
        );

        // Emit event to signal the submission of a new transaction.
        emit SubmitTransaction(msg.sender, txIndex, _to, _value, _data);
    }

    // Function to confirm a transaction.
    // Can only be called by an owner and if the transaction hasn't been confirmed or executed.
    function confirmTransaction(uint256 _txIndex)
        public
        onlyOwner
        txExists(_txIndex)
        notExecuted(_txIndex)
        notConfirmed(_txIndex)
    {
        Transaction storage transaction = transactions[_txIndex];
        
        // Increase the number of confirmations for this transaction.
        transaction.numConfirmations += 1;
        isConfirmed[_txIndex][msg.sender] = true;

        // Emit event to signal confirmation.
        emit ConfirmTransaction(msg.sender, _txIndex);
    }

    // Function to execute a transaction.
    // Can only be called by an owner if the required number of confirmations has been reached.
    function executeTransaction(uint256 _txIndex)
        public
        onlyOwner
        txExists(_txIndex)
        notExecuted(_txIndex)
    {
        Transaction storage transaction = transactions[_txIndex];

        // Ensure the transaction has enough confirmations.
        require(
            transaction.numConfirmations >= numConfirmationsRequired,
            "cannot execute tx"
        );

        // Mark the transaction as executed.
        transaction.executed = true;

        // Transfer the value and call the optional data.
        (bool success,) =
            transaction.to.call{value: transaction.value}(transaction.data);
        require(success, "tx failed");

        // Emit event to signal the transaction has been executed.
        emit ExecuteTransaction(msg.sender, _txIndex);
    }

    // Function to revoke a previously confirmed transaction.
    // Can only be called by an owner and if the transaction hasn't been executed.
    function revokeConfirmation(uint256 _txIndex)
        public
        onlyOwner
        txExists(_txIndex)
        notExecuted(_txIndex)
    {
        Transaction storage transaction = transactions[_txIndex];

        // Ensure the transaction has already been confirmed by the sender.
        require(isConfirmed[_txIndex][msg.sender], "tx not confirmed");

        // Decrease the number of confirmations for this transaction.
        transaction.numConfirmations -= 1;
        isConfirmed[_txIndex][msg.sender] = false;

        // Emit event to signal the revocation of confirmation.
        emit RevokeConfirmation(msg.sender, _txIndex);
    }

    // Function to get the list of all wallet owners.
    function getOwners() public view returns (address[] memory) {
        return owners;
    }

    // Function to get the total number of transactions submitted.
    function getTransactionCount() public view returns (uint256) {
        return transactions.length;
    }

    // Function to get the details of a specific transaction by its index.
    function getTransaction(uint256 _txIndex)
        public
        view
        returns (
            address to,
            uint256 value,
            bytes memory data,
            bool executed,
            uint256 numConfirmations
        )
    {
        Transaction storage transaction = transactions[_txIndex];

        // Return all the details of the transaction.
        return (
            transaction.to,
            transaction.value,
            transaction.data,
            transaction.executed,
            transaction.numConfirmations
        );
    }
}





