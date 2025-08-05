// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TokenWithCombinedLock {

    mapping(address => uint256) private balances;
    uint256 private totalSupply_;

    // lock by block number
    uint256 public minTradeBlock;

    // flexible boolean lock
    bool public paused;

    address public owner;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Paused(bool isPaused);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // block lock modifier
    modifier blockLock() {
        require(block.number > minTradeBlock, "Token transfers are locked by block number");
        _;
    }

    // pause modifier
    modifier notPaused() {
        require(!paused, "Token transfers are paused");
        _;
    }

    constructor(uint256 _minBlock) {
        owner = msg.sender;
        minTradeBlock = _minBlock;
        totalSupply_ = 1_000_000 ether;
        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }

    // combine both checks on transfer
    function transfer(address to, uint256 amount) public blockLock notPaused returns (bool) {
        require(amount > 0, "Zero amount");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        balances[to] += amount;

        emit Transfer(msg.sender, to, amount);
        return true;
    }

    // admin can pause/unpause
    function setPause(bool _paused) public onlyOwner {
        paused = _paused;
        emit Paused(_paused);
    }

}
