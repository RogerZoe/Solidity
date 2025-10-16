// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@chainlink/contracts/src/v0.8/automation/interfaces/ILogAutomation.sol";

// Contract B (CounterUpkeep) → listens via Chainlink Automation log trigger
contract CounterUpkeep is ILogAutomation {
    uint256 public counter;

    event CounterIncremented(uint256 newValue);

    // Called off-chain by Chainlink nodes when matching log is detected
    function checkLog(
        Log calldata log,
        bytes memory /* checkData */
    )
        external
        pure
        override
        returns (bool upkeepNeeded, bytes memory performData)
    {
        upkeepNeeded = true;                  // Always perform upkeep when event seen
        performData = log.data;               // Pass log data forward
    }

    // Called on-chain if checkLog returns true
    function performUpkeep(bytes calldata performData) external override {
        // Decode log data (from emitting contract)
        (address user, uint256 value) = abi.decode(performData, (address, uint256));

        counter++;
        emit CounterIncremented(counter);

        // Example extra logic: require(value > 100) to filter
    }
}
