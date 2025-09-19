// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Receiver {
    event GotData(address sender, uint amount, bytes data);

    fallback() external payable {
        emit GotData(msg.sender, msg.value, msg.data);
    }
}

contract Sender {
    function sendToReceiver(address payable receiver) public payable {
        require(msg.value > 0, "need ether");

        // sending ether with data
        (bool success, ) = receiver.call{value: msg.value}("lanja");
        require(success, "call failed");
    }
}
