// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// This contract will RECEIVE ether
contract Receiver {
    event Received(address sender, uint amount);

    // fallback with some complex logic that costs gas
    fallback() external payable {
        // do something that needs more than 2300 gas
        uint x = 1;
        for (uint i = 0; i < 1000; i++) {
            x += i;  // some storage-like operations
        }
        emit Received(msg.sender, msg.value);
    }
}

// This contract will TRY to send ether using .send()
contract Sender {
    function sendEther(address payable to) public payable {
        require(msg.value > 0, "Need ether to send");

        bool success = to.send(msg.value); // sends 2300 gas
        require(success, "Send failed");   // will fail if fallback consumes too much gas
    }
}
