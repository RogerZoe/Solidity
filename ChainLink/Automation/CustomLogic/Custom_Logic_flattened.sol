
// File: @chainlink/contracts/src/v0.8/automation/AutomationBase.sol


pragma solidity ^0.8.0;

contract AutomationBase {
  error OnlySimulatedBackend();

  /**
   * @notice method that allows it to be simulated via eth_call by checking that
   * the sender is the zero address.
   */
  function _preventExecution() internal view {
    // solhint-disable-next-line avoid-tx-origin
    if (tx.origin != address(0) && tx.origin != address(0x1111111111111111111111111111111111111111)) {
      revert OnlySimulatedBackend();
    }
  }

  /**
   * @notice modifier that allows it to be simulated via eth_call by checking
   * that the sender is the zero address.
   */
  modifier cannotExecute() {
    _preventExecution();
    _;
  }
}

// File: @chainlink/contracts/src/v0.8/automation/interfaces/AutomationCompatibleInterface.sol


pragma solidity ^0.8.0;

// solhint-disable-next-line interface-starts-with-i
interface AutomationCompatibleInterface {
  /**
   * @notice method that is simulated by the keepers to see if any work actually
   * needs to be performed. This method does does not actually need to be
   * executable, and since it is only ever simulated it can consume lots of gas.
   * @dev To ensure that it is never called, you may want to add the
   * cannotExecute modifier from KeeperBase to your implementation of this
   * method.
   * @param checkData specified in the upkeep registration so it is always the
   * same for a registered upkeep. This can easily be broken down into specific
   * arguments using `abi.decode`, so multiple upkeeps can be registered on the
   * same contract and easily differentiated by the contract.
   * @return upkeepNeeded boolean to indicate whether the keeper should call
   * performUpkeep or not.
   * @return performData bytes that the keeper should call performUpkeep with, if
   * upkeep is needed. If you would like to encode data to decode later, try
   * `abi.encode`.
   */
  function checkUpkeep(bytes calldata checkData) external returns (bool upkeepNeeded, bytes memory performData);

  /**
   * @notice method that is actually executed by the keepers, via the registry.
   * The data returned by the checkUpkeep simulation will be passed into
   * this method to actually be executed.
   * @dev The input to this method should not be trusted, and the caller of the
   * method should not even be restricted to any single registry. Anyone should
   * be able call it, and the input should be validated, there is no guarantee
   * that the data passed in is the performData returned from checkUpkeep. This
   * could happen due to malicious keepers, racing keepers, or simply a state
   * change while the performUpkeep transaction is waiting for confirmation.
   * Always validate the data passed in.
   * @param performData is the data which was passed back from the checkData
   * simulation. If it is encoded, it can easily be decoded into other types by
   * calling `abi.decode`. This data should not be trusted, and should be
   * validated against the contract's current state.
   */
  function performUpkeep(bytes calldata performData) external;
}

// File: @chainlink/contracts/src/v0.8/automation/AutomationCompatible.sol


pragma solidity ^0.8.0;



abstract contract AutomationCompatible is AutomationBase, AutomationCompatibleInterface {}

// File: ChainLink/Automation/Custom_Logic.sol


pragma solidity ^0.8.7;



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
