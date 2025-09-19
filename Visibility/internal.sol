 // SPDX-License-Identifier: MIT

 // ==> PURPOSE  OF INDICATING THAT UNDER WHICH LICENSE NUMBER THE CODE IS RELEASED  

  // VISISBILITY ==> TELLS US WHO CAN CALL/ACCESS THE STATE VARIABLES AND FUNCTIONS 

 pragma solidity ^0.8.0;

 // ONLY WITHIN THE CONTRACT AND CHILD CONTRACT.................
 contract check1
 {
    uint  internal hlo=12;
    function get() public view returns(uint)
    {
        return hlo;
    }    
 }
 // METHOD 2==> CONCEPT OF INHERITANCE..........        NOT HAPPEN

 contract check2
 {
    uint  internal hlo=123;
 }
 contract check22 is check2
 {
    function get() public view returns(uint)
    {
        return hlo;       
    }
 }
