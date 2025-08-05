// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
contract MyContract is ERC721 {
    uint public tokenId;
    constructor() ERC721("MyNFT", "MNFT") {}

    function Mint() public {
        _safeMint(msg.sender,tokenId);
        tokenId++;
    }
}

