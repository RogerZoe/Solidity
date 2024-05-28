// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract hlo
{


      //  RECEIVE DATA(BYTES) AND EHTERS...............
     fallback() external  payable  
     {

     } 
     

     function get() public view returns(uint)
     {
        return address(this).balance;
     }
}