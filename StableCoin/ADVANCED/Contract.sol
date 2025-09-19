// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract Intro is ERC20, Ownable, ReentrancyGuard {
    AggregatorV3Interface public feed;

    mapping(address => uint256) public collateral; // ETH deposited in wei
    mapping(address => uint256) public debt; // MSC minted

    uint256 public constant MIN_COLLATERAL_RATIO = 200; // 200% over-collateralized
    uint256 public constant LIQUIDATION_BONUS = 10; // 10% bonus for liquidator

    // ---------------- EVENTS ----------------
    event CollateralDeposited(address indexed user, uint256 amount);
    event CollateralRedeemed(address indexed user, uint256 amount);
    event Minted(address indexed user, uint256 amount);
    event Burned(address indexed user, uint256 amount);
    event Liquidated(
        address indexed user,
        address indexed liquidator,
        uint256 debtRepaid,
        uint256 collateralTaken
    );

    constructor(address feedAddress)
        ERC20("Mini token", "MSC")
        Ownable(msg.sender)
    {
        feed = AggregatorV3Interface(feedAddress);
    }

    // ---------------- USER FUNCTIONS ----------------

    function depositCollateral() public payable {
        require(msg.value > 1e18, "Must deposit >1 ETH");
        collateral[msg.sender] += msg.value;
        emit CollateralDeposited(msg.sender, msg.value);
    }

    function mint(uint256 amount) public {
        require(amount > 0, "Amount must be >0");
        uint256 usdValue = conversion(collateral[msg.sender]);
        require(
            usdValue >=
                ((debt[msg.sender] + amount) * MIN_COLLATERAL_RATIO) / 100,
            "Not enough collateral"
        );

        debt[msg.sender] += amount;
        _mint(msg.sender, amount);
        emit Minted(msg.sender, amount);
    }

    function burn(uint256 amount) public {
        require(amount > 0, "Amount must be >0");
        require(amount <= debt[msg.sender], "Burn amount exceeds debt");

        debt[msg.sender] -= amount;
        _burn(msg.sender, amount);
        emit Burned(msg.sender, amount);
    }

    function redeemCollateral(uint256 amountWei) public nonReentrant {
        require(amountWei > 0, "Amount must be >0");
        require(
            amountWei <= collateral[msg.sender],
            "Withdrawing more than collateral"
        );

        uint256 newCollateral = collateral[msg.sender] - amountWei;
        uint256 usdValue = conversion(newCollateral);

        require(
            debt[msg.sender] == 0 ||
                (usdValue * 100) / debt[msg.sender] >= MIN_COLLATERAL_RATIO,
            "Collateral ratio too low"
        );

        collateral[msg.sender] = newCollateral;
        payable(msg.sender).transfer(amountWei);
        emit CollateralRedeemed(msg.sender, amountWei);
    }

    // ---------------- LIQUIDATION ----------------

    function liquidate(address user, uint256 debtToRepay) public nonReentrant {
        require(debtToRepay > 0, "Must repay more than 0");
        require(
            getHealthFactor(user) < MIN_COLLATERAL_RATIO,
            "User is healthy"
        );
        require(debtToRepay <= debt[user], "Cannot repay more than user owes");

        uint256 ethPrice = getEthPrice();
        // Calculate ETH to give liquidator: (debt * (100 + bonus)) / price
        uint256 collateralToTake = (debtToRepay *(100 + LIQUIDATION_BONUS) * 1e18) / (ethPrice * 100);
        if (collateralToTake > collateral[user]) {
            collateralToTake = collateral[user];
        }

        // Liquidator must send MSC to cover the debt
        transferFrom(msg.sender, address(this), debtToRepay);
        _burn(address(this), debtToRepay); // protocol burns the received MSC

        debt[user] -= debtToRepay;
        collateral[user] -= collateralToTake;

        payable(msg.sender).transfer(collateralToTake);

        emit Liquidated(user, msg.sender, debtToRepay, collateralToTake);
    }

    // ---------------- VIEWS ----------------

    function getHealthFactor(address user) public view returns (uint256) {
        if (debt[user] == 0) return type(uint256).max;
        uint256 usdCollateral = conversion(collateral[user]);
        return (usdCollateral * 100) / debt[user]; // percent, 200% = safe
    }

    function conversion(uint256 amountWei) public view returns (uint256) {
        (, int256 price, , , ) = feed.latestRoundData();
        // ETH price 8 decimals, ETH in wei (1e18) -> scale to 18 decimals USD
        return (uint256(price) * amountWei * 1e10) / 1e18;
    }

    function getEthPrice() public view returns (uint256) {
        (, int256 price, , , ) = feed.latestRoundData();
        return uint256(price) * 1e10; // scale to 18 decimals
    }

    // Fallback to accept ETH
    receive() external payable {
        depositCollateral();
    }
}
