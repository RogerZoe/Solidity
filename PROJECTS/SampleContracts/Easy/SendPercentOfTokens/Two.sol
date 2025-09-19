// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// user sends tokens to someone, 1% goes to target

contract TransferTokenAndPercentageToTargetAddress {

    address public target;  //THIS ADDRESS IS FOR TAX FEE/WALLET FEE

    mapping(address => uint256) public balanceOf;
    uint256 public totalSupply;

    constructor(uint256 _totalSupply, address _target) {
        require(_target != address(0), "Invalid target address");  // used to check the null address "0x000..."
        totalSupply = _totalSupply;
        balanceOf[msg.sender] = totalSupply;
        target = _target;
    }

    function transfer(address _to, uint256 amount) external {
        require(_to != address(0), "Invalid recipient address");
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");

        uint256 fee = amount / 100; // 1% fee

        // subtract full amount from sender
        balanceOf[msg.sender] -= amount;

        // credit recipient minus fee
        balanceOf[_to] += amount - fee;

        // send fee to target
        balanceOf[target] += fee;

        // check balances still consistent (for debugging, could be removed in production)
        // total tokens should remain the same
        assert(
            balanceOf[msg.sender] + balanceOf[_to] + balanceOf[target]
            <= totalSupply
        );
    }
}