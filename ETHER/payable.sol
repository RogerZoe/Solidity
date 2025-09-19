// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

// Define a contract named `First`
contract First {

    // Declare a public variable `Owner1` of type `address payable` 
    // This will store the address of the contract's owner.
    address payable public Owner1;

    // Another way to declare and initialize the `Owner` variable.
    // The `payable` keyword indicates that this address can receive Ether.
    // This variable will store the address of the contract owner.
    address payable public Owner;

    // Constructor to initialize the `Owner` variable with the address of 
    // the account that deploys the contract (msg.sender).
    constructor() {
        Owner = payable(msg.sender);  // Assign the contract deployer’s address to `Owner`.
    }

    // A payable function named `Hello`. This function can receive Ether when called.
    function Hello() public payable {
        // The function body is empty, but because it's payable,
        // it can accept Ether and add it to the contract's balance.
    }

    // Function to return the contract's current balance in Wei (1 Ether = 10^18 Wei).
    function GEt() public view returns(uint) {
        return address(this).balance;  // Returns the balance of the contract.
    }
}
