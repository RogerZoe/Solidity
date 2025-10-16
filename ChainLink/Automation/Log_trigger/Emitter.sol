// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Contract A (EventEmitter) → emits an event.

contract EventEmitter {
    event SomethingHappened(address   user, uint256 value);

    function doSomething(uint256 value) external {
        // Just emit an event when user calls this function
        emit SomethingHappened(msg.sender, value);
    }
}

