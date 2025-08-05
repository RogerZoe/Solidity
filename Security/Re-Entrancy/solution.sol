// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract SafeWithdraw {
    mapping(address => uint) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        uint amount = balances[msg.sender];

        // ✅ Effect before interaction
        balances[msg.sender] = 0;

        // ✅ Interaction
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Transfer failed");
    }
}

//=============> USING TRANSIENT  STORAGE

contract ReentrancyWithTransient {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        // Load the transient lock
        uint256 locked;
        assembly {
            locked := tload(0x1) // 0x1 is an arbitrary key
        }
        require(locked == 0, "Reentrant call");

        // Set the transient lock
        assembly {
            tstore(0x1, 1)
        }

        uint256 amount = balances[msg.sender];
        balances[msg.sender] = 0;
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed");

        // No need to reset; transient resets automatically after tx
    }
}
