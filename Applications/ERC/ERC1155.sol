// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract MyGameItems is ERC1155 {
    uint256 public constant GOLD = 0;
    uint256 public constant SWORD = 1;
    uint256 public constant SHIELD = 2;

    constructor() ERC1155("https://mygame.example/api/item/{id}.json") {
        _mint(msg.sender, GOLD, 1000, "");
        _mint(msg.sender, SWORD, 10, "");
        _mint(msg.sender, SHIELD, 5, "");
    }
}
