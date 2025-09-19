 // SPDX-License-Identifier: MIT
 pragma solidity ^0.8.0;

 contract global
 {
     //PREDEFINED VARIBALES (INBUILT)

      uint public num=block.number;
      uint public num5=block.timestamp;
    //   uint public num1=block.difficulty;
      uint public num2=block.gaslimit;
      address public num3=msg.sender;

 }