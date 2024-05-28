// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract dyn
{
    bytes public num;   // we cant intialize here............
   constructor ()
   {num='123abcdef';}

    function help() public 
    {
        num.push('c');
    }

    


}