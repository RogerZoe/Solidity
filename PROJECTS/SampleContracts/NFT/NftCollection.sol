// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// You will:

// Create images for your NFT collection (ex: “image_1.jpg”, “image_2.jpg” etc)
// Describe them in JSON metadata files (with attributes like name, description, traits)
// Upload these to IPFS (typically via Pinata) so they are permanently decentralized
// Deploy a Solidity ERC721 smart contract that points to those metadata files
// Then mint NFTs (one per token ID) referencing those metadata
// Finally test them on OpenSea testnet

// Upload images folder → get images CID
// Add that CID to each JSON file’s "image": "ipfs://..."
// Upload JSON folder → get JSON CID (you gave it above)
// Use the JSON CID in baseTokenURI
// Deploy the contract
// Mint tokens
// View them on OpenSea testnet


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Strings.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract MyNFT is ERC721, Ownable {
    using Strings for uint256;

    uint256 private _tokenIds;

    string public baseTokenURI = "ipfs://bafybeifke7zlmjp7ii5jpega3sbnejcbxhzhxkf6bymux23aptdjwbhzle/"; // Replace this with your JSON CID

    constructor() ERC721("MyNFT", "MNFT") Ownable(msg.sender) {}

    function mint() public returns (uint256) {
        _tokenIds += 1;
        _safeMint(msg.sender, _tokenIds);
        return _tokenIds;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return string(
            abi.encodePacked(baseTokenURI, tokenId.toString(), ".json")
        );
    }

    function setBaseTokenURI(string memory newBaseURI) public onlyOwner {
        baseTokenURI = newBaseURI;
    }
}

 // CID of JSON and IMAGES
// bafybeifke7zlmjp7ii5jpega3sbnejcbxhzhxkf6bymux23aptdjwbhzle  json
// bafybeiancudwjhu7f3mxpmeeyyuin33fjwks5hgk73uulywzvsobttn6re   images