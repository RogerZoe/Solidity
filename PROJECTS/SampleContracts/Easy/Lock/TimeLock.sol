// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;
// Think of it like a weekly allowance or escrow.
// You can deposit ether into the contract.
// But you cannot withdraw instantly.
// You must wait 1 week before you are allowed to withdraw.
// If you want, you can also extend that lock period by calling increaseLockTime.

contract LockTime {
    mapping(address => uint256) public Ethamount;
    mapping(address => uint256) public timestamp;

    function deposit() public payable {
        Ethamount[msg.sender] += msg.value;
        timestamp[msg.sender] += block.timestamp + 10 seconds;  //Lock time 
    }

    function withdraw() public {
        require(Ethamount[msg.sender] > 0, "Not Enough funds");
        require(
            timestamp[msg.sender] < (block.timestamp),
            "Still their is time"
        );
        uint256 amount = Ethamount[msg.sender];
        Ethamount[msg.sender] = 0;
        (bool sent, ) = msg.sender.call{value: amount}(" ");
        require(sent, "Transaction Failed");
    }

    function increaseLockTime(uint256 _secondsToIncrease) public {
        timestamp[msg.sender] += _secondsToIncrease;
    }
}
