// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MTK") {
        _mint(msg.sender, 20 * 10**18);
    }

    // function transfer(address to,uint amount) public override  returns(bool)   {
        
    // }
}
//  1. `transfer(address to, uint amount)`
// - Transfers tokens **directly** from `msg.sender` to another address.
// - Use case: Simple peer-to-peer token send.

// 🔹 2. `approve(address spender, uint amount)`
// - Lets the token owner **authorize** another address (called the “spender”) to spend up to `amount` tokens **on their behalf**.

//  🔹 3. `transferFrom(address from, address to, uint amount)`
// - Allows the **spender** to transfer `amount` of tokens **from `from` to `to`**, provided `from` approved them earlier.
// - Used in **decentralized exchanges**, **subscriptions**, and **delegated payments**.

//  🔹 4. `allowance(address owner, address spender)`
// - Returns how many tokens a spender is **still allowed to spend** from a particular owner's balance.