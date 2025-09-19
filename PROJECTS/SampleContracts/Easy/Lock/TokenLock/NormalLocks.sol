// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// When you deploy a token, sometimes you do not want people to immediately trade it. Reasons might include:

// avoid snipe bots during initial launch
// control a vesting schedule (lock-up period)
// restrict transfers in case of a hack or vulnerability
// enable/disable trading based on project rules
// staged token releases (for example, every 6 months)

//BLOCK NUMBER METHOD


contract BlockLockToken {

    mapping(address => uint256) private __balanceOf;
    uint256 private __totalSupply = 1_000_000 ether;

    constructor() {
        __balanceOf[msg.sender] = __totalSupply;
    }

    function balanceOf(address account) public view returns (uint256) {
        return __balanceOf[account];
    }

    // block number lock modifier
    modifier checkBlock() {
        require(block.number > 6000000, "Can Not Trade");
        _;
    }

    // transfer function with block lock
    function transfer(address _to, uint256 _value) public checkBlock returns (bool success) {
        if (_value > 0 && _value <= __balanceOf[msg.sender]) {
            __balanceOf[msg.sender] -= _value;
            __balanceOf[_to] += _value;
            emit Transfer(msg.sender, _to, _value);
            return true;
        }
        return false;
    }

    event Transfer(address indexed from, address indexed to, uint256 value);
}

//BOOLEAN METHOD

contract FlagLockToken {

    mapping(address => uint256) private __balanceOf;
    uint256 private __totalSupply = 1_000_000 ether;

    address public owner;
    bool public transferable = false;

    constructor() {
        owner = msg.sender;
        __balanceOf[msg.sender] = __totalSupply;
    }

    function balanceOf(address account) public view returns (uint256) {
        return __balanceOf[account];
    }

    // modifier to allow only owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not Owner");
        _;
    }

    // modifier to check transferable flag
    modifier istransferable() {
        require(transferable == true, "Can Not Trade");
        _;
    }

    // setter to toggle transferable flag
    function setTransferable(bool _choice) public onlyOwner {
        transferable = _choice;
    }

    // transfer function with flag check
    function transfer(address _to, uint256 _value) public istransferable returns (bool success) {
        if (_value > 0 && _value <= __balanceOf[msg.sender]) {
            __balanceOf[msg.sender] -= _value;
            __balanceOf[_to] += _value;
            emit Transfer(msg.sender, _to, _value);
            return true;
        }
        return false;
    }

    event Transfer(address indexed from, address indexed to, uint256 value);
}
