// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

// This is a simple contract to demonstrate the order of execution in Solidity
contract first {
    uint public age;           // State variable to store age
    string public name;        // State variable to store name
    string a = "Arif";         // Local variable initialized with a default value

    // Constructor to initialize age and name
    constructor(uint _age, string memory _name) {
        age = _age;
        name = _name;
    }
}

// This contract has a constructor that initializes `add` and `name1`
// The constructor parameters are both strings
contract second {
    string public add;        // State variable to store address (or any string)
    string public name1;     // State variable to store name

    // Constructor to initialize add and name1
    constructor(string memory _age, string memory _name) {
        add = _age;
        name1 = _name;
    }
}

// The `lop` contract inherits from the `first` contract and passes parameters
// to the `first` contract's constructor
contract lop is first(12, "qwer") {
    // This contract initializes `first` with age=12 and name="qwer"
}

// The `four` contract attempts to inherit from both `first` and `second` contracts
// It demonstrates the order of constructor execution and how to properly call base contract constructors
contract four is second, first {
    // Constructor to initialize both `first` and `second` contracts
    // The constructor of `second` is called first, followed by `first`
    constructor() second("ndcl", "sdk") first(12, "zxcv") {
        // Constructor body can be used for additional initialization if needed.
        
    }
}

// Note: The order of inheritance and constructor calls is crucial. 
// The constructors of base contracts are executed in the order they are specified in the inheritance list.
