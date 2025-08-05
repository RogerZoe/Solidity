// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Array {
    uint256[] public arr; // DYNAMIC ARRAY IS NOT CREATED IN FUNCTION......The phrase "dynamic array is not created in function" was meant to emphasize that the declaration and initial allocation of storage for dynamic arrays occur at the contract level, while functions are used to interact with and modify these arrays dynamically during execution.
    string[] public str = ["add", "a", "a"];
    uint256[] public zrr = [12, 3, 4, 2, 2];

    constructor() {
        arr.push(123);
    }
}

contract DynamicArrayExample {
    uint256[] public dynamicArray;

    constructor() {
        // Initialize the dynamic array in the constructor
        dynamicArray.push(1);
        dynamicArray.push(2);
        dynamicArray.push(3);
    }

    function addToDynamicArray(uint256 newValue) public {
        // Add a new value to the dynamic array
        dynamicArray.push(newValue);
    }

    function getDynamicArray() public view returns (uint256[] memory) {
        // Return the dynamic array
        return dynamicArray;
    }
}
