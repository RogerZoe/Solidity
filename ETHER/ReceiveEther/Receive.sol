// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract hlo
{

     //  RECEIVE  ONLY ETHERS.............
    receive() external payable {
        
    }
    function Chek() public view returns(uint)
    {
        return address(this).balance;
    }
}