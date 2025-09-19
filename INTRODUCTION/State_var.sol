// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract variable {
    // STORES IN BLOCKCHAIN (STORAGE) PERMANENTLY
    uint256 public num1; // STATE VARIABLE IS THE ONE WHICH INSIDE THE CONTRACT BUT OUTSIDE THE FUNCTION
    bool public temp;
    bytes12 public name;

    // INITIALIZE IN THREE WAYS

    //1.==>
    uint256 public num = 122;

    //2. ==>
    constructor() {
        num1 = 12;
        temp = true;
        name;
    }

    //3. ==>
    function get() public {
        num1 = 100;
        temp = false;
        num = 150;
    }
    // State variables are suitable for storing contract-specific data that needs to be accessed and modified by multiple functions within the contract
}

//    once a state variable is set, its value cannot be changed without a transaction[ means a excecuting function that changes the state of the variable]"
contract HEllo {
    int256 public age = 12;
    uint256 public constant age1 = 12;

    function hlo() public {
        age = 34; // State variables like age can have their values changed, but this requires executing a function that modifies the variable, and this function must be called through a transaction.
    }
}
