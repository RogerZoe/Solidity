// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Base contract definition
contract BaseContract {
    uint public baseValue; // Public variable to store the base value

    // Constructor to initialize the base value
    constructor(uint _baseValue) {
        baseValue = _baseValue;
    }

    // Public function that returns a string
    function baseFunction() public pure returns (string memory) {
        return "Base Function";
    }
}

// Derived contract inheriting from BaseContract
contract DerivedContract is BaseContract {
    uint public derivedValue; // Public variable to store the derived value

    // Constructor to initialize both base and derived values
    constructor(uint _baseValue, uint _derivedValue) BaseContract(_baseValue) {
        derivedValue = _derivedValue;
    }

    // Public function that returns a string specific to the derived contract
    function derivedFunction() public pure returns (string memory) {
        return "Derived Function";
    }

    // Additional function to call the base function from the derived contract
    function callBaseFunction() public pure returns (string memory) {
        return baseFunction();
    }
}

// Example contract to demonstrate interaction with BaseContract and DerivedContract
contract InteractionExample {
    BaseContract public baseInstance; // Instance of BaseContract
    DerivedContract public derivedInstance; // Instance of DerivedContract

    // Constructor to initialize instances of BaseContract and DerivedContract
    constructor(uint _baseValue, uint _derivedValue) {
        baseInstance = new BaseContract(_baseValue);
        derivedInstance = new DerivedContract(_baseValue, _derivedValue);
    }

    // Function to interact with the base contract and return its value and function output
    function interactWithBase() public view returns (uint, string memory) {
        return (baseInstance.baseValue(), baseInstance.baseFunction());
    }

    // Function to interact with the derived contract and return its values and function outputs
    function interactWithDerived() public view returns (uint, uint, string memory, string memory) {
        return (
            derivedInstance.baseValue(), 
            derivedInstance.derivedValue(), 
            derivedInstance.baseFunction(), 
            derivedInstance.derivedFunction()
        );
    }

    // Function to interact with the derived contract calling the base function
    function interactWithDerivedCallingBase() public view returns (string memory) {
        return derivedInstance.callBaseFunction();
    }
}

