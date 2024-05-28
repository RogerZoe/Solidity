// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract fix
{
    bytes5 public num=0x1233223135;
    bytes5 public temp;

    constructor(bytes5 _temp)
    {
        temp=_temp;
    }

    function ret() public view returns(bytes5)
    {
        return temp[3];
    }
    function len() public view returns(uint)
    {
        return temp.length;
    }
}