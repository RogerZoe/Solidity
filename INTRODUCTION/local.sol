 // SPDX-License-Identifier: MIT
 pragma solidity ^0.8.0;
 contract local_var
 {
    uint public num=12;

            // DECLARE ONLY INSIDE THE FUNCTION in the Stack [not in storage]

    function name() public view returns(uint ,uint,string memory)
    {
        uint  six=6;
        six =six+1;

        string memory Name="Arif"; //it gives error ,because by default strings  are  stored in contract level...so we use memeory
        // specifies that the data is temporary and should only persist for the duration of the function call
        return( six,num,Name);
    }
 }