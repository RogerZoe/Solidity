// SPDX-License-Identifier: MIT
 pragma solidity ^0.8.0;
 contract check
 {
    uint public num=12;
    //! HERE IAM ONLY READING THE STATE VARIABLE SO WE USE VIEW 
    function hlo() public view   returns(uint) 
    {
        return num;
    }
    //! HERE NOT READING AND CHANGING THE STATE VARAIBLES(ANYTHING)
    function hlo1(uint num3) public pure  returns(uint)  
    {
        uint  result =num3 +12;
        return result;
    }
    
 }
 