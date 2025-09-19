 // SPDX-License-Identifier: MIT

 // ==> PURPOSE  OF INDICATING THAT UNDER WHICH LICENSE NUMBER THE CODE IS RELEASED  

  // VISISBILITY ==> TELLS US WHO CAN CALL/ACCESS THE STATE VARIABLES AND FUNCTIONS 

 pragma solidity ^0.8.0;

 contract check1
 {
    uint  public hlo=12;
    function get() public view returns(uint)
    {
        return hlo;
    }    
 }
 // METHOD 2==> CONCEPT OF INHERITANCE..........        NOT HAPPEN

 contract check2
 {
    uint  public hlo=123;
 }
 contract check22 is check2
 {
    function get() public  view returns(uint)
    {
        return hlo;       
    }
 }

 // METHOD 3 ==>  DIFFERENT CONTRACT BUT IN SAME FILE..........         happen but create an instance then call it 

 contract check3
 {
    uint public  hlo=123;
 }
 contract check33
 {
    check3 public isinstance;

    constructor(address _check3)
    {
        isinstance=check3(_check3);
    }

    function get() public  view returns(uint)
    {
        return isinstance.hlo();
    }
 }


 