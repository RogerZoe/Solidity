// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Let users subscribe by paying ETH

// Track their next renewal time

// Let owner check who’s active

// Allow users to cancel and get partial refund

contract SubscriptionService {
    address public owner;
    uint256 public price = 0.01 ether;
    uint256 public interval = 30 days;

    struct Subscriber {
        uint256 nextPaymentDue;
        uint256 amountPaid;
        bool active;
    }

    mapping(address => Subscriber) public subscribers;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Subscribe or renew subscription
    function subscribe() external payable {
        require(msg.value == price, "Incorrect amount");

        Subscriber storage user = subscribers[msg.sender];

        if (user.active && block.timestamp < user.nextPaymentDue) {
            // Renew: extend current subscription
            user.nextPaymentDue += interval;
        } else {
            // New subscription or expired one
            user.nextPaymentDue = block.timestamp + interval;
            user.active = true;
        }

        user.amountPaid += msg.value;
    }

    // Cancel your subscription
    function cancelSubscription() external {
        Subscriber storage user = subscribers[msg.sender];
        require(user.active, "Not subscribed");
        require(block.timestamp < user.nextPaymentDue, "Already expired");

        user.active = false;

        // Partial refund logic (optional)
        uint256 remaining = user.nextPaymentDue - block.timestamp;
        uint256 refundAmount = (price * remaining) / interval;

        payable(msg.sender).transfer(refundAmount);
    }

    // Check if a user is active
    function isActive(address user) public view returns (bool) {
        return subscribers[user].active && block.timestamp < subscribers[user].nextPaymentDue;
    }

    // Withdraw funds to owner
    function withdraw() external onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
