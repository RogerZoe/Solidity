// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

 contract Data
 {
    
    uint[]  public arr= [1,2,3,4];

    function Storage() public {
        uint[] storage _arr=arr;   //direclty points to arr;
        _arr[1]=69; // CHANGE.......
    }
    function Mem()  view public {
        uint[] memory _arr=arr; 
        _arr[1]=69; //NOT CHANGE........... it will copy the original Storage array so that it changes were not  reflect .
    }

 }

