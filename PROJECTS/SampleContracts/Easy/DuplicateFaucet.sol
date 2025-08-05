// anyone can send ETH to the contract (fund the faucet)
// ✅ requestFunds() lets users claim 0.01 ether
// ✅ cooldown of 1 hour between claims
// ✅ owner can withdraw or adjust the faucet parameters
// ✅ uses receive() and fallback() to accept ether

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EtherFaucet {
    address public owner;
    uint256 public withdrawalAmount = 0.01 ether;
    uint256 public cooldownTime = 1 hours;

    // track last time a user claimed
    mapping(address => uint256) public lastClaimed;

    constructor() {
        owner = msg.sender;
    }

    // fund the faucet by sending ether to it
    receive() external payable {}

    // fallback in case someone sends plain ether
    fallback() external payable {}

    // user can request funds
    function requestFunds() external {
        require(address(this).balance >= withdrawalAmount, "Faucet is empty");
        require(
            block.timestamp >= lastClaimed[msg.sender] + cooldownTime,
            "Try again later"
        );

        lastClaimed[msg.sender] = block.timestamp;

        (bool sent, ) = msg.sender.call{value: withdrawalAmount}("");
        require(sent, "Transfer failed");
    }

    // owner can withdraw leftover funds if needed
    function withdrawFaucetFunds() external {
        require(msg.sender == owner, "Not owner");
        (bool sent, ) = owner.call{value: address(this).balance}("");
        require(sent, "Withdraw failed");
    }

    // owner can change how much to send per request
    function setWithdrawalAmount(uint256 amount) external {
        require(msg.sender == owner, "Not owner");
        withdrawalAmount = amount;
    }

    // owner can change cooldown
    function setCooldownTime(uint256 timeInSeconds) external {
        require(msg.sender == owner, "Not owner");
        cooldownTime = timeInSeconds;
    }
}