// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

//  deposit eth [ORACLE] => COLLATERAL -> MINT --> BURN

contract Intro is ERC20, Ownable {
    AggregatorV3Interface public feed;

    mapping(address => uint256) public collateral; // fixed typo
    mapping(address => uint256) public debt;       // fixed typo

    constructor(address add) ERC20("Mini token", "MSC") Ownable(msg.sender) {
        feed = AggregatorV3Interface(add);
    }

    function depositCollateral() public payable {
        require(msg.value > 1e18, "Should deposit >1 ETH"); // 1 ETH = 1e18 wei
        collateral[msg.sender] += msg.value;
    }

    function mint(uint256 amount) public {   // == > TAKING STABLECOINS THOURGH YOUR ADDED COLLATEROL
        require(amount > 0, "Amount must be > 0");
        uint256 usdValue = Conversion(collateral[msg.sender]);
        require(usdValue >= (debt[msg.sender] + amount) * 2, "Not enough collateral");
        debt[msg.sender] += amount;
        _mint(msg.sender, amount);
    }

    function burn(uint256 amount) public {
        require(amount > 0, "Amount must be > 0");
        require(amount <= debt[msg.sender], "Burn amount exceeds debt");
        debt[msg.sender] -= amount;
        _burn(msg.sender, amount);
    }

    function withdrawCollateral(uint256 amountWei) public {
        require(amountWei > 0, "Amount must be > 0");
        require(amountWei <= collateral[msg.sender], "Withdrawing more than collateral");

        uint256 newCollateral = collateral[msg.sender] - amountWei;
        uint256 usdValue = Conversion(newCollateral);

        require(debt[msg.sender] == 0 || usdValue >= debt[msg.sender] * 2, "Collateral ratio too low");

        collateral[msg.sender] = newCollateral;
        payable(msg.sender).transfer(amountWei);
    }

    function Conversion(uint256 amountWei) internal view returns (uint256) {
        (, int256 price, , , ) = feed.latestRoundData(); // ETH/USD price
        // price has 8 decimals, ETH has 18 decimals
        return (uint256(price) * amountWei) / 1e26; // convert wei to USD
    }

    // Fallback to accept ETH
    receive() external payable {
        depositCollateral();
    }
}
