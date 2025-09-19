// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract SmartWallet {
    address public owner;
    mapping(address => bool) public whitelist;
    uint256 public balance;

    event AccessGranted(address indexed _address, string message);
    event AccessRevoked(address indexed _address, string message);
    event FundsAdded(address indexed _address, uint256 amount);
    event FundsSpent(address indexed _address, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier onlyOwnerOrPermissioned(address _address) {
        require(msg.sender == owner || whitelist[_address], "Not authorized");
        _;
    }

    function addFunds(uint256 amount, address _address) public onlyOwnerOrPermissioned(msg.sender) {
        require(balance + amount <= 10000, "Exceeds the maximum wallet limit");
        balance += amount;
        emit FundsAdded(_address, amount);
    }

    function spendFunds(uint256 amount, address _address) public onlyOwnerOrPermissioned(msg.sender) {
        require(balance >= amount, "Insufficient funds");
        balance -= amount;
        emit FundsSpent(_address, amount);
    }

    function addAccess(address _address) public onlyOwner {
        whitelist[_address] = true;
        emit AccessGranted(_address, "Access granted");
    }

    function revokeAccess(address _address) public onlyOwner {
        whitelist[_address] = false;
        emit AccessRevoked(_address, "Access revoked");
    }

    function viewBalance() public view returns (uint256) {
        return balance;
    }
}
