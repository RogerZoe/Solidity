// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Array
{

 uint[] public arr;
 constructor()
 {
    arr.push(123);
 }
}

contract DynamicArrayExample {
    uint[] public dynamicArray;
    constructor() {
        // Initialize the dynamic array in the constructor
        dynamicArray.push(1);
        dynamicArray.push(2);
        dynamicArray.push(3);
    }

    function addToDynamicArray(uint newValue) public {
        // Add a new value to the dynamic array
        dynamicArray.push(newValue);
    }

    function getDynamicArray() public view returns (uint[] memory) {
        // Return the dynamic array
        return dynamicArray;
    }
}

