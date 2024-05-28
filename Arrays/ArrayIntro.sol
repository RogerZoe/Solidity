// SPDX-License-Identifier: MIT
 pragma solidity ^0.8.0;

 contract Arrays_Intro
 {
    
     uint[4] public arr;
     uint[7] public arr2=[1,23,4,2,5,4];

     string[3] public str=["as0","sf","sfssdf"];
     address[4] public ad;

     function get() public  view returns(uint[4] memory)
     {
            return arr;
     }
     function get1() public  view returns(uint[7] memory)
     {
            return arr2;
     }
     function get2() public  view returns(string[3] memory)
     {
            return str;
     }
     function get3() public  view returns(address[4] memory)
     {
            return ad;
     }
 }