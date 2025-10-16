// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/automation/AutomationCompatible.sol";


contract Lottery is AutomationCompatible {
    uint256 public lastTimeStamp;
    uint256 public interval;
    address[] public players;
    address public recentWinner;

    constructor(uint256 _interval) {
        interval = _interval;
        lastTimeStamp = block.timestamp;
    }

    function enter() public payable {
        require(msg.value > 0.01 ether, "Not enough ETH!");
        players.push(msg.sender);
    }

    // Called off-chain by Automation nodes
    function checkUpkeep(bytes calldata /* checkData */) 
        external 
        view 
        override 
        returns (bool upkeepNeeded, bytes memory /* performData */) 
    {
        upkeepNeeded = (block.timestamp - lastTimeStamp) > interval && players.length > 0;
    }

    // Called on-chain by Automation nodes if checkUpkeep() returned true
    function performUpkeep(bytes calldata /* performData */) external override {
        require((block.timestamp - lastTimeStamp) > interval, "Too early!");
        lastTimeStamp = block.timestamp;

        // Pick a winner (super naive random for demo)
        uint256 winnerIndex = uint256(block.timestamp) % players.length;
        recentWinner = players[winnerIndex];
        payable(recentWinner).transfer(address(this).balance);

        delete players; // reset
    }
}
