// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// This is super common in modern token design.
// For example, you might want to:

// Burn some tokens on every transfer (deflationary)

// Take a developer fee to fund ongoing work

// Redistribute to holders (reflection or redistribution)

// Add to a liquidity pool

// Support a charity

// Instead of relying on people sending a fee manually, you program the transfer to automatically route a portion of the transaction to another address.

// This pattern guarantees:
// ✅ consistent collection
// ✅ no cheating
// ✅ automatic logic enforced on-chain

// 1.user sends ETH to contract, contract forwards 1%
contract ReceiveETHERandSendPercentageToAnotherAddress{

    // a fixed address to receive a 1% cut
    address payable target = payable(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);  //any address

    // fallback function gets called on any plain ether transfer
    fallback () payable external { 
       
        // send 1% to the target
        target.transfer(msg.value / 100);

        // rest stays in contract balance
    }
}