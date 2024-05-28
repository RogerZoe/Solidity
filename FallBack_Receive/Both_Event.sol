// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract hlo
{

    event Log(string _fun,address _sender,uint _val,bytes _data);


fallback() external  payable  
     {
        emit Log("fallback",msg.sender,msg.value,msg.data);
     } 

    receive() external payable {
         emit Log("receive",msg.sender,msg.value," ");
    }
    function Chek() public view returns(uint)
    {
        return address(this).balance;
    }
}