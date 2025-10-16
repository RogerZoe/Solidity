// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
 A simple ERC20-like token that supports gasless transfers using off-chain signatures.
*/

contract GaslessPermitToken {
    string public name = "Gasless Permit Token";
    string public symbol = "GPT";
    uint8 public decimals = 18;
    uint256 public totalSupply = 1000 * 10 ** uint256(decimals);

    mapping(address => uint256) public balanceOf;
    mapping(address => uint256) public nonces;

    constructor() {
        balanceOf[msg.sender] = totalSupply; // Deployer gets all tokens
    }

    // Normal ERC20 transfer
    function transfer(address to, uint256 amount) external {
        require(balanceOf[msg.sender] >= amount, "Not enough tokens");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
    }

    // Gasless transfer using off-chain signature
    function transferWithPermit(
        address from,
        address to,
        uint256 amount,
        uint256 nonce,
        bytes memory signature
    ) external {
        bytes32 message = keccak256(
            abi.encodePacked(from, to, amount, nonce, address(this))
        );

        address signer = recoverSigner(message, signature);
        require(signer == from, "Invalid signature");
        require(nonce == nonces[from], "Invalid nonce");

        nonces[from]++;
        require(balanceOf[from] >= amount, "Not enough tokens");

        balanceOf[from] -= amount;
        balanceOf[to] += amount;
    }

    // Helper to recover signer
    function recoverSigner(bytes32 message, bytes memory sig)
        internal
        pure
        returns (address)
    {
        bytes32 ethSignedMessage = keccak256(
            abi.encodePacked("\x19Ethereum Signed Message:\n32", message)
        );

        (bytes32 r, bytes32 s, uint8 v) = splitSignature(sig);
        return ecrecover(ethSignedMessage, v, r, s);
    }

    // Helper to split the signature into r, s, v
    function splitSignature(bytes memory sig)
        internal
        pure
        returns (bytes32 r, bytes32 s, uint8 v)
    {
        require(sig.length == 65, "Invalid signature length");
        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := byte(0, mload(add(sig, 96)))
        }
    }
}


