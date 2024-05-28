
// SPDX-License-Identifier: MIT
 pragma solidity ^0.8.0;

 contract Operations
 {
           uint[7] public arr2=[1,23,4,2,5,4];

       // RETURN THE VALUE AT PARTICULAR INDEX
       
       function getvalue(uint i) public view returns(uint)
       {
        return arr2[i];
       }
       function getvalue1(uint i) public 
       {
                   arr2[i]=23;  // update value
                   
                   uint temp;
                   temp=arr2[2];  //get 

                   delete arr2[4];      //delete
       }
       function getvalue2() public view returns(uint[7] memory )
       {
        return arr2;     // return an array.........
       }
 }


 //  MOSTLY AVOID RETURNNIG AN ARRAY DUE TO GAS COST..........


 contract ArrayInfun
 {



    /* 1.*/function set(uint[4]  memory arr) public pure returns(uint[4] memory)
    {
        return arr;
    }
    /* 2.*/function set2() public pure returns(uint[] memory)
    {

        uint[] memory temp =new uint[](4); 
        return temp;
    }
 }