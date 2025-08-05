// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract Check
{
    uint  public num=123;
    address public owner=msg.sender;
    function check() public  view 
    {
        require(num<1234,"ushfhshf");
    }
    
    
    function add() public  {
        require(msg.sender==owner ,"you are not the owner");
        num=num-23;
    }
    function cool() public pure returns (string memory ) {
        return "arif";
    }
}