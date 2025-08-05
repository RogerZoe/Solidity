// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Hello {
    uint public oneWei = 1 wei; // Stores 1 Wei
    bool public isOneWei = 1 wei == 1; // Checks if 1 Wei equals 1

    uint public oneEther = 1 ether; // Stores 1 Ether
    bool public isOneEther = 1 ether == 1e18; // Checks if 1 Ether equals 10¹⁸ Wei
}



contract UnitConversion {
    function convertWeiToEther(uint weiAmount) public pure returns (uint) {
        // Calculate the function selector
          bytes4 selector = bytes4(keccak256("convertWeiToEther(uint256)"));

        return weiAmount / 1 ether; // Converts Wei to Ether
        
    }

    function convertEtherToWei(uint etherAmount) public pure returns (uint) {
        return etherAmount * 1 ether; // Converts Ether to Wei
    }
}
