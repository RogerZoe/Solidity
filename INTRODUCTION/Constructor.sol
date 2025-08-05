 // SPDX-License-Identifier: MIT
 pragma solidity ^0.8.0;
 contract hlo
 {
    string public name;
    uint public Age;
    // constructor()
    // {
    //     name="arif";
    // }


    //BEFOR DEPLOYING THE CONTRACT YOU HAVE TO GIVE THE VALUES 
    constructor(uint age,string memory Name)
    {
              name=Name;
            Age=age;
    }
 }