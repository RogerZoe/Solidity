// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Child {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }

    function getName() public view returns (string memory) {
        return name;
    }
}


contract Factory {
    address public childAddress;

    // This function creates a new Child contract
    function createChild(string memory _name) public {
        Child child = new Child(_name); // Creates new Child contract
        childAddress = address(child); // Store the address of the new contract
    }

    // This function interacts with the created Child contract
    function getChildName() public view returns (string memory) {
        return Child(childAddress).getName(); // Calls getName() from the child
    }
}
