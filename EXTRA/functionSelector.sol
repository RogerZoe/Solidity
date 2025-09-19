// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// This contract is used to generate function selectors using keccak256 hash.
contract fake {

    // Returns the first 4 bytes (function selector) of the keccak256 hash of the function signature
    function Get(string memory fun) public pure returns(bytes4){
        return bytes4(keccak256(bytes(fun))); // E.g., "Details(string,uint256)" → 0x8880eae8
    }
}

// This contract emits the calldata when Details is called
contract hash {
    event log(bytes); // Used to log raw calldata

    // This function accepts a name and age and emits the raw msg.data (calldata)
    function Details(string memory name, uint256 age) public returns(string memory,uint){
        emit log(msg.data); // Emits the full calldata including function selector + encoded params
        return (name, age);
    }
}

// 0x8880eae8                                            ← Function selector for Details(string,uint256)
// 0000000000000000000000000000000000000000000000000000000000000020  ← offset of dynamic data ("Arif") from start of data
// 0000000000000000000000000000000000000000000000000000000000000017  ← age = 23 (in hex)
// 0000000000000000000000000000000000000000000000000000000000000004  ← string length = 4
// 4172696600000000000000000000000000000000000000000000000000000000  ← "Arif" padded to 32 bytes

