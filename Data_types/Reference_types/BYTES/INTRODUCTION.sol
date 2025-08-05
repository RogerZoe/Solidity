// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;


contract intro
{
    // bytes[]  public num=[["01","01","01"]];       // ITS IS DYNAMIC BYTES ARRAY,SO WE CANT INTIALIZE OUTSIDE THE FUNCTION...........
    // LIKE THIS SET and INITLIALIZE IT......|
    bytes[] public set;
    function set1() public  {
        set.push("123");
        set.push("0123");
        set.push(hex"02");
    }

    bytes public num=hex"ab4321";
    bytes public num2=hex"ab3214f6";      // should be even digits

}