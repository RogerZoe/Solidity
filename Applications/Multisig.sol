// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract MultiSig {
    // Required number of confirmations to execute a transaction
    uint256 public numOfConfirmations;

    // Structure to store transaction details
    struct Transaction {
        uint256 value;           // Amount of ETH to send
        uint256 confirmations;   // Number of confirmations received (can be removed for optimization)
        address to;              // Recipient address
        bool executed;           // Execution status
    }

    // List of wallet owners
    address[] internal owners;
    
    // List of all submitted transactions
    Transaction[] internal transactions;

    // Mapping to check if an address is an owner
    mapping(address => bool) internal isOwner;

    // Mapping to check if a specific owner confirmed a specific transaction
    mapping(uint256 => mapping(address => bool)) internal isConfirmed;

    // Constructor to initialize owners and number of required confirmations
    constructor(address[] memory _owners, uint256 _numOfConfirmations) {
        require(_owners.length > 0, "Owners required");
        require(_numOfConfirmations > 0, "Confirmations required");

        for (uint256 i = 0; i < _owners.length; i++) {
            address owner = _owners[i];

            require(owner != address(0), "Invalid owner");
            require(!isOwner[owner], "Duplicate owner");

            isOwner[owner] = true;
            owners.push(owner);
        }

        require(_numOfConfirmations <= owners.length, "Too many confirmations");
        numOfConfirmations = _numOfConfirmations;
    }

    // Events for tracking contract activity
    event SubmitTransaction(uint256 indexed txIndex, address indexed owner, address indexed to, uint256 value);
    event ConfirmTransaction(uint256 indexed txIndex, address indexed owner);
    event ExecuteTransaction(uint256 indexed txIndex, bool success);
    event RevokeTransaction(uint256 indexed txIndex, uint256 newConfirmations, address indexed owner);

    // Modifier to restrict function access to wallet owners only
    modifier onlyOwner() {
        require(isOwner[msg.sender], "Not an owner");
        _;
    }

    // Modifier to ensure the transaction exists
    modifier txExists(uint256 _txIndex) {
        require(_txIndex < transactions.length, "Transaction does not exist");
        _;
    }

    // Submit a new transaction with ETH to be sent
    function submit(address _to) public payable onlyOwner {
        require(_to != address(0), "Invalid recipient");
        require(msg.value > 1, "Insufficient ETH");

        uint256 txIndex = transactions.length;

        transactions.push(
            Transaction({
                value: msg.value,
                confirmations: 0,
                to: _to,
                executed: false
            })
        );

        emit SubmitTransaction(txIndex, msg.sender, _to, msg.value);
    }

    // Confirm a pending transaction
    function confirm(uint256 txIndex) public onlyOwner txExists(txIndex) {
        require(!isConfirmed[txIndex][msg.sender], "Already confirmed");

        Transaction storage transaction = transactions[txIndex];

        transaction.confirmations += 1;
        isConfirmed[txIndex][msg.sender] = true;

        emit ConfirmTransaction(txIndex, msg.sender);

        // Execute if required number of confirmations met
        if (IsConfirmation(txIndex)) {
            execute(txIndex);
        }
    }

    // Revoke a previously submitted confirmation
    function revokeConfirmation(uint256 txIndex) public onlyOwner txExists(txIndex) {
        require(isConfirmed[txIndex][msg.sender], "Not yet confirmed");

        Transaction storage transaction = transactions[txIndex];

        transaction.confirmations -= 1;
        isConfirmed[txIndex][msg.sender] = false;

        emit RevokeTransaction(txIndex, transaction.confirmations, msg.sender);
    }

    // Internal function to check if transaction is fully confirmed
    function IsConfirmation(uint256 txIndex)
        internal
        view
        txExists(txIndex)
        returns (bool)
    {
        uint256 count = 0;

        for (uint256 i = 0; i < owners.length; i++) {
            if (isConfirmed[txIndex][owners[i]]) {
                count += 1;
            }
        }

        return count >= numOfConfirmations;
    }

    // Internal function to execute a transaction
    function execute(uint256 txIndex) internal txExists(txIndex) {
        Transaction storage transaction = transactions[txIndex];

        require(!transaction.executed, "Already executed");

        (bool success, ) = transaction.to.call{value: transaction.value}("");
        if (success) {
            transaction.executed = true;
            emit ExecuteTransaction(txIndex, true);
        } else {
            revert("Transaction failed");
        }
    }

    // Public view function to get confirmation count of a transaction
    function getConfirmations(uint256 txIndex) public view returns (uint256 count) {
        for (uint256 i = 0; i < owners.length; i++) {
            if (isConfirmed[txIndex][owners[i]]) {
                count += 1;
            }
        }
    }
}
