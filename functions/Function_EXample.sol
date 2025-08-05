 // SPDX-License-Identifier: MIT
 pragma solidity ^0.8.0;
 contract check
 {
    //Defining public pure sqrt function
    function sqrt(uint _num) public pure returns(uint){
       _num = _num ** 2;
       return _num;
    }
    // Defining a public pure function to demonstrate................
    // calling of sqrt function....
    function add() public pure returns(uint){
      uint num1 = 4;
      uint num2 = 2;
      uint sum = num1 + num2;
      return sqrt(sum); // calling function
 }
 }