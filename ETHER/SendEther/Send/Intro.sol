// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract Sender {
    function sendEther(address payable to) public payable {
        require(msg.value > 0, "Need ether to send");

        bool success = to.send(msg.value); // sends 2300 gas
        require(success, "Send failed");   // will fail if fallback consumes too much gas
    }
}