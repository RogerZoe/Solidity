// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Crowd {
    //CONTRIBUTORS providing Money to the Manager[COMPANY].....for Company Uses..
    //BUT IN NORMAL CASE WHETHER WE DONT KNOW THE MANAGER IS A FRAUD OR SOMETHING ...HOW CAN WE SOLVE IT?
    // BY USING SMART CONTRACT ..
    //CONTRIBUTORS PROVIDE THE MONEY ON TO THE SMART CONTRACT ,THEN FROM THAT CONTRACT ,MANAGER CAN HANDLE IT ..ONLY TERMS ACCEPTING IN THE SMART CONTRACT ...
    //IF MANAGER WANT TO ACCESS THE SMART CONTRACT THEN HE NEEDS MINIMUM 50% OF PERMISSION FROM THE CONTRIBUTORS...

    mapping(address => uint256) public Contributors;
    address public manager;
    uint256 public min_Contribution;
    uint256 public Deadline;
    uint256 public target;
    uint256 public RaisedFUnd;
    uint256 public No_of_Contributors;

    // FIRST WE SET THE VALUES OF ==> " TARGET AND DEADLINE " and intial values that is to be fixed....
    constructor(uint256 _target, uint256 _deadline) {
        target = _target;
        // Deadline=_deadline;
        Deadline = block.timestamp + _deadline;
        min_Contribution = 100 wei;
        manager = msg.sender;
    }

    function SndEth() public payable {
        require(block.timestamp < Deadline, " Deadline has Exceed");
        require(msg.value >= min_Contribution, " Not enough Contribution");

        // CHECKING THE CONTRIBUTOR CONDTION,WHERE HE NOW SENDING THE ETHER OR ALREADY SENT..
        if (Contributors[msg.sender] == 0) {
            No_of_Contributors++;
        }

        Contributors[msg.sender] += msg.value; // Adds the amount of Ether sent by the current caller (msg.sender) to their existing contribution balance stored in the Contributors mapping.

        // Contributors[msg.sender]  ==> this represents that this particular msg.sender has some ethers ..............
        RaisedFUnd += msg.value; // adding the funds
    }

    // FOR CHECKING BALANCE...
    function getContract() public view returns (uint256) {
        return address(this).balance;
    }

    function REFUND() public {
        require(
            block.timestamp > Deadline && RaisedFUnd < target,
            "You are not eligible for refund"
        );
        require(Contributors[msg.sender] > 0);

        // here TRANSFERING the  msg.sender into some variable called "USER"
        address payable user = payable(msg.sender); //This line converts the msg.sender address into a payable address type. In Solidity, to send Ether from a contract to an address, that address needs to be of type payable. We're essentially creating a variable called user that represents the address of the sender (msg.sender) and can receive Ether.
        user.transfer(Contributors[msg.sender]);  //  retrieves the amount of Ether the sender has contributed to the contract, and this amount is transferred to the sender.
        Contributors[msg.sender] = 0;             //Because after receivng there is no money in you wallet ,then to show  it ..............==>This ensures that the sender cannot withdraw the same Ether multiple times and keeps track of the remaining contributions accurately.
    }

    //DIRECTLY MANAGER CANT CALL TO THE SMART CONTRAT ,HE NEEDS TO SEND THE REQUEST TO THE CONTRIBUTORS ,SO THAT WE NEED TO CREATE A STRUCTURAL FORM OF REQUEST..........
        struct Request
        {
            string description;
            address payable receipient;
            uint value;
            bool completed;
            uint noOfVoters;
            mapping(address=>bool) voters; //checking  for  duplicated votes  
        }

        mapping(uint=>Request) public request; //FOR ONE OR MORE REQUESTS;
        uint public numRequest; // for incrementing the above index value; 

         // so this only accessed by Manager;

         modifier OnlyManager()
         {
            require(msg.sender==manager," only manager can access");
            _;
         }

         function CreateREquest(string memory _descrption,address payable _receipient,uint _value) public OnlyManager
         {
            // if we want to use struct  inside the function then use ==> "STORAGE"
                  Request storage newRequest= request[numRequest]; // if we have one or more Request then we need to access the varibales of struct so thats why we creat a new Variable...
                   numRequest++;
                   newRequest.description=_descrption;
                   newRequest.receipient=_receipient;
                   newRequest.completed=false;  // change will be happen in down
                   newRequest.value=_value;
                   newRequest.noOfVoters=0;  //change will be happen in down
                   
         }

         //now we perform request..
         function Voterequest(uint _requestno)public   
         {
            require(Contributors[msg.sender]>=0," You must be a contributor");
            Request storage thisRequest=request[_requestno];
            // for only one to vote each 
            require(thisRequest.voters[msg.sender]==false," you have already voted");
            thisRequest.voters[msg.sender]=true;  //if not set the value to true;
            thisRequest.noOfVoters++;
         }
         
         //now After getting the request for manager,he can take the amount from the contributors[smart contract] ,ONLY WHEN 50% OF CONTRIBUOTRS CAN ACCEPT IT...

       function makePayment(uint _requestno) public OnlyManager
       {
         require(RaisedFUnd >=target," not reached the target amount");
            Request storage thisRequest=request[_requestno];
                require(thisRequest.completed==false," the request has been completed");                                                // used to check ,like obviuosly not to makepayment for 
                require(thisRequest.noOfVoters>No_of_Contributors/2," contributors majority not supported to you"); // 50% condition..
               thisRequest.receipient.transfer(thisRequest.value);
               thisRequest.completed=true;
       }

}
