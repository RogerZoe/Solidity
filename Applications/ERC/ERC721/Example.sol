// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BoredApeStyleNFT is ERC721, Ownable {
    uint256 public constant MAX_SUPPLY = 10_000;
    uint256 public constant PRICE = 0.08 ether;
    uint256 public totalSupply;
    bool public saleIsActive;
    string private baseURI;

    constructor(string memory _baseURI) ERC721("BoredApeStyle", "BAYC") Ownable(msg.sender) {
        baseURI = _baseURI;
    }

    function mint(uint256 amount) external payable {
        require(saleIsActive, "Sale not active");
        require(amount > 0 && amount <= 20, "Mint 1-20 NFTs");
        require(totalSupply + amount <= MAX_SUPPLY, "Exceeds supply");
        require(msg.value == PRICE * amount, "Wrong ETH amount");

        unchecked {
            for (uint256 i = 0; i < amount; ++i) {
                _safeMint(msg.sender, totalSupply++);
            }
        }
    }

    function setSaleState(bool state) external onlyOwner {
        saleIsActive = state;
    }

    function setBaseURI(string calldata uri) external onlyOwner {
        baseURI = uri;
    }

    function withdraw() external onlyOwner {
        (bool success, ) = payable(owner()).call{value: address(this).balance}("");
        require(success, "Withdrawal failed");
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_ownerOf(tokenId) != address(0), "Token does not exist");
        return string.concat(baseURI, Strings.toString(tokenId), ".json");
    }
}

// Owner deploys contract with baseURI

// Calls setSaleState(true)

// Users call mintApe(amount) and send ETH

// NFTs are minted to their address

// Metadata served via IPFS or external server
