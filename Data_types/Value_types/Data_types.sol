 // SPDX-License-Identifier: MIT

 // ==> PURPOSE  OF INDICATING THAT UNDER WHICH LICENSE NUMBER THE CODE IS RELEASED  
// The following are called value types because their variables will always be passed by value, 
// i.e. they are always copied when they are used as function arguments or in assignments.


 pragma solidity ^0.8.0;
 contract basic
 {
     // <== VALUE TYPES ===>
     uint public  num1=12;
     bool public  num2 =true;
     int  public num3=-12;
     address public num4=0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;  // ==> HOLD 20 BYTE VALUE     
 }
 // bool:
// Use Case: For representing binary choices, conditions, or boolean flags.
// Example: A smart contract that manages permission settings where a bool variable could indicate whether a user has admin rights.


// int/uint:

// Use Case: For storing integer values, with int for signed integers and uint for unsigned integers.
// Example: Tracking a user's balance, counting the number of transactions, etc.

// fixed/ufixed types:

// Use Case: For fixed-point decimal arithmetic.
// Example: Handling financial calculations where precise decimal points are crucial.

// address:

// Use Case: For storing Ethereum addresses.
// Example: Identifying the owner of a contract, recording the destination address for fund transfers.

// enum:

// Use Case: For creating user-defined types with a finite set of values.
// Example: Defining states for a state machine, like "Pending," "Approved," and "Rejected."

 
 

 

 