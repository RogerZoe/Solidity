 // SPDX-License-Identifier: MIT

 // ==> PURPOSE  OF INDICATING THAT UNDER WHICH LICENSE NUMBER THE CODE IS RELEASED  

 pragma solidity ^0.8.0;

 contract ONE {
     
    uint public age=22;
    uint public row=31;
    function fun() public  pure 
    {
        uint Num=32;
        string memory  name="arif";
      
    }
    
 //  STATE VARIABLE UPDATING...........
    function setter(uint _age,uint _row )public 
    {
             age=_age;
             row=_row;
    }
}
contract  two is ONE
{
    ONE p1=new ONE();

         //1. STATE VARIABLE UPDATING............
    function update_values() public 
    {
             p1.setter(321,123);            
    }
      // 2. UPDATING THE STATE VARIBALES..............................
    function update(uint _age) public 
    {
         age=_age;
    }



}