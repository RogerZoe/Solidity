// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Creating a contract
contract Types {
    // Declaring state variables
    // of type array
    uint256[6] data1;

    // Defining function to add
    // values to an array
    function array_example()
        public
        view
        returns (int256[5] memory, uint256[6] memory)
    {
        int256[5] memory data = [int256(50), -63, 77, -28, 90];
        // data1 = [uint(10), 20, 30, 40, 50, 60];
        return (data, data1);
    }
}

contract hlo {
    uint256[5] public arr;

    // arr[1]=13; // not Allowed,because Solidity asks you to follow a certain order to avoid confusion
    // and make sure your smart contract is properly set up before it starts working.
    function fun() public pure returns (uint256) {
        uint256[] memory ar = new uint256[](3);
        ar[1] = 1232;
        return ar[1];
    }
}
