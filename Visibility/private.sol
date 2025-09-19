 // SPDX-License-Identifier: MIT

 // ==> PURPOSE  OF INDICATING THAT UNDER WHICH LICENSE NUMBER THE CODE IS RELEASED  

  // VISISBILITY ==> TELLS US WHO CAN CALL/ACCESS THE STATE VARIABLES AND FUNCTIONS 

 pragma solidity ^0.8.0;

// WHILE DEFINING THE FUNCTIONS AND STATE VARIABLES WE HAVE 4 DIFFERENT WAYS  

// METHOD 1 ==> CALLING INSIDE THE CONTRACT...          HAPPEN
 contract check1
 {
    uint  private hlo=12;
    function get() public view returns(uint)
    {
        return hlo;
    }    
 }
 // METHOD 2==> CONCEPT OF INHERITANCE..........        NOT HAPPEN

 contract check2
 {
    uint  private hlo=123;
 }
 contract check22 is check2
 {
    // function get() public returns(uint)
    // {
    //     return hlo;       
    // }
 }

 // METHOD 3 ==>  DIFFERENT CONTRACT BUT IN SAME FILE..........         NOT HAPPEN

 contract check3
 {
    uint private  hlo=123;
 }
 contract check33
 {

    // function get() public returns(uint)
    // {
    //     return hlo;
    // }
 }



