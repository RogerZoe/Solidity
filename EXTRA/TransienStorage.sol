// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// =======> SYNTAX   <==========

// Store 123 into transient storage at key 0x0
// assembly {
//     tstore(0x0, 123)
// }

// // Load value from key 0x0
// uint256 val;
// assembly {
//     val := tload(0x0)
// }

contract TransientExample {
    // Set a transient value
    function set(uint256 value) external {
        assembly {
            // Store 'value' at key 0xabc
            tstore(0xabc, value)
        }
    }

    // Read the transient value
    function get() external   returns (uint256 result) {
        assembly {
            result := tload(0xabc)
            //Clear it manually
            tstore(0xabc,0)
        }
    }
}
// Q: Why use external in tstore/tload?
// A: So that both can be called from outside (like from another contract) in the same transaction, allowing transient data to be retained between them.

contract Caller {
    function doBoth(TransientExample temp) external returns (uint256) {
        temp.set(42);        // same transaction
        return temp.get();   // same transaction → returns 42
    }
}