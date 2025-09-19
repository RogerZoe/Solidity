 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyContract {
    // Define a struct to represent your data structure
    struct MyStruct {
        uint256 id;
        string name;
        // Add more fields as needed
    }

    // Declare a dynamic array of structs as a state variable
    MyStruct[] public myStructs;

    // Function to add a new struct instance to the array
    function addStruct(uint256 _id, string memory _name) public {
        MyStruct memory newStruct = MyStruct(_id, _name);
        myStructs.push(newStruct);
    }

    // Function to get the count of structs stored in the array
    function getStructsCount() public view returns (uint256) {
        return myStructs.length;
    }

    // Function to get a struct by index
    function getStructByIndex(uint256 index) public view returns (uint256, string memory) {
        require(index < myStructs.length, "Index out of bounds");
        MyStruct memory retrievedStruct = myStructs[index];
        return (retrievedStruct.id, retrievedStruct.name);
    }
}