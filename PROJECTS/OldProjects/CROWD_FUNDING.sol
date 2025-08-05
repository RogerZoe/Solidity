// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Crowd {
    //  CONTRIBUTORS providing Money to the Manager[COMPANY].....for Company Uses..
    //  BUT IN NORMAL CASE WHETHER WE DONT KNOW THE MANAGER IS A FRAUD OR SOMETHING ...HOW CAN WE SOLVE IT?
    //  BY USING SMART CONTRACT ..
    //  CONTRIBUTORS PROVIDE THE MONEY ON TO THE SMART CONTRACT ,THEN FROM THAT CONTRACT ,MANAGER CAN HANDLE IT ..ONLY TERMS ACCEPTING IN THE SMART CONTRACT ...
    //  IF MANAGER WANT TO ACCESS THE SMART CONTRACT THEN HE NEEDS MINIMUM 50% OF PERMISSION FROM THE CONTRIBUTORS...

    // This contract implements a crowdfunding mechanism with safeguards to ensure accountability.
    // Contributors provide funds to a smart contract managed by a manager (company representative).
    // The manager can only withdraw funds for specific purposes after receiving approval from at least 50% of contributors.

    mapping(address => uint256) public Contributors; // Tracks the amount of Ether each contributor has sent
    address public manager; // Address of the manager who creates and manages requests
    uint256 public min_Contribution; // Minimum contribution required to participate
    uint256 public Deadline; // Deadline for the crowdfunding campaign
    uint256 public target; // Target funding amount to be raised
    uint256 public RaisedFUnd; // Total funds raised so far
    uint256 public No_of_Contributors; // Total number of unique contributors

    // Constructor to initialize the crowdfunding campaign parameters
    constructor(uint256 _target, uint256 _deadline) {
        target = _target; // Set the target amount
        Deadline = block.timestamp + _deadline; // Set the deadline as the current time plus the input duration
        min_Contribution = 100 wei; // Set a minimum contribution amount
        manager = msg.sender; // Set the manager to the contract deployer
    }

    // Function to allow contributors to send Ether
    function SndEth() public payable {
        require(block.timestamp < Deadline, " Deadline has exceeded"); // Ensure contributions are made before the deadline
        require(
            msg.value >= min_Contribution,
            " Contribution is below the minimum"
        );

        // Check if the sender is contributing for the first time
        if (Contributors[msg.sender] == 0) {
            No_of_Contributors++; // Increment the count of unique contributors
        }

        // Update the sender's contribution and total funds raised
        Contributors[msg.sender] += msg.value;
        RaisedFUnd += msg.value;
    }

    // Function to retrieve the contract's balance
    function getContract() public view returns (uint256) {
        return address(this).balance; // Return the contract's Ether balance
    }

    // Function to allow contributors to request a refund if the target is not met
    function REFUND() public {
        require(
            block.timestamp > Deadline && RaisedFUnd < target,
            " Refunds are only allowed after the deadline if the target is not met"
        );
        require(
            Contributors[msg.sender] > 0,
            " You have no contributions to refund"
        );

        // Refund the sender their contribution
        address payable user = payable(msg.sender); // Convert sender's address to payable
        user.transfer(Contributors[msg.sender]); // Transfer the contribution back to the sender
        Contributors[msg.sender] = 0; // Reset the contributor's balance to zero
    }

    // Struct to represent a spending request
    struct Request {
        string description; // Description of the request
        address payable receipient; // Address of the recipient (manager or company)
        uint256 value; // Amount requested
        bool completed; // Whether the request has been completed
        uint256 noOfVoters; // Number of contributors who approved the request
        mapping(address => bool) voters; // Tracks who has voted for this request
    }

    mapping(uint256 => Request) public request; // Mapping of all requests by their ID
    uint256 public numRequest; // Counter to assign unique IDs to requests

    // Modifier to restrict access to the manager
    modifier OnlyManager() {
        require(
            msg.sender == manager,
            " Only the manager can perform this action"
        );
        _;
    }

    // Function to create a new spending request (only accessible by the manager)
    function CreateRequest(
        string memory _descrption,
        address payable _receipient,
        uint256 _value
    ) public OnlyManager {
        Request storage newRequest = request[numRequest]; // Access the new request in storage
        numRequest++; // Increment the request ID counter

        // Set request details
        newRequest.description = _descrption;
        newRequest.receipient = _receipient;
        newRequest.value = _value;
        newRequest.completed = false; // Initialize as not completed
        newRequest.noOfVoters = 0; // Initialize the voter count
    }

    // Function to allow contributors to vote for a spending request
    function Voterequest(uint256 _requestno) public {
        require(
            Contributors[msg.sender] > 0,
            " You must be a contributor to vote"
        ); // Ensure the sender is a contributor
        Request storage thisRequest = request[_requestno]; // Access the specific request

        // Ensure the contributor hasn't already voted
        require(
            thisRequest.voters[msg.sender] == false,
            " You have already voted"
        );
        thisRequest.voters[msg.sender] = true; // Mark the sender as having voted
        thisRequest.noOfVoters++; // Increment the vote count
    }

    // Function to execute a spending request after approval (only accessible by the manager)
    function makePayment(uint256 _requestno) public OnlyManager {
        require(RaisedFUnd >= target, " Funds raised are less than the target"); // Ensure the target amount is met
        Request storage thisRequest = request[_requestno]; // Access the specific request

        // Ensure the request hasn't already been completed
        require(
            thisRequest.completed == false,
            " The request has already been completed"
        );

        // Ensure the request has at least 50% contributor approval
        require(
            thisRequest.noOfVoters > No_of_Contributors / 2,
            " The request does not have majority approval"
        );

        // Transfer the requested funds to the recipient
        thisRequest.receipient.transfer(thisRequest.value);
        thisRequest.completed = true; // Mark the request as completed
    }
}
