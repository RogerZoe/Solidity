// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
// 0x194146544073844DFdA12790823243f954F1A2D2
import "@openzeppelin/contracts/proxy/Clones.sol";
import "./Intro.sol";

 contract Factory {
    // Attach Clones library to address type
    using Clones for address;

    // Address of the main implementation (logic contract)
    address public immutable implementation;

    // Event to log new clone creation
    event CloneCreated(address indexed newClone, address indexed creator);

    // Constructor: Deploy logic contract once
    constructor() {
        implementation = address(new Vault());
    }

    // Function: Create a minimal proxy
    function createClone() external returns (address) {
        // Step 1: Create a minimal proxy that delegates to implementation
        address clone = implementation.clone();

        // Step 2: Initialize the clone (set owner or other state)
        Vault(clone).initialize(msg.sender);

        // Step 3: Emit event for logging
        emit CloneCreated(clone, msg.sender);

        // Step 4: Return clone address
        return clone;
    }
}

// 0x67763334617096e726Ab83b23C7cE9a372BBA402
