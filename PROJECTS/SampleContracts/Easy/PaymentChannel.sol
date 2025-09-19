// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Sender -> (Alice)	Deploys the contract with Ether and recipient’s address
// 	Off-chain	Alice signs messages for increasing amounts to Bob (e.g., 1 ETH, 2 ETH…)
// 	Recipient (Bob)	At the end, Bob takes the highest signed message and submits it on-chain
// 	Contract	Pays Bob the signed amount and refunds Alice the rest
// 	Timeout	If Bob never closes, Alice gets her funds back after expiry

contract PaymentChannel {
    address payable public sender;
    address payable public recipient;
    uint256 public expiration;

    constructor(address payable _recipient, uint256 durationInSeconds) payable {
        sender = payable(msg.sender);
        recipient = _recipient;
        expiration = block.timestamp + durationInSeconds;
    }

    function isValidSignature(uint256 amount, bytes memory signature)
        internal
        view
        returns (bool)
    {
        bytes32 messageHash = getEthSignedMessageHash(
            keccak256(abi.encodePacked(address(this), amount))
        );
        return recoverSigner(messageHash, signature) == sender;
    }

    function close(uint256 amount, bytes memory signature) external {
        require(msg.sender == recipient, "Only recipient can close");
        require(isValidSignature(amount, signature), "Invalid signature");

        recipient.transfer(amount);
        // selfdestruct(sender);
    }

    function extend(uint256 newExpiration) external {
        require(msg.sender == sender, "Only sender can extend");
        require(newExpiration > expiration, "New expiration must be greater");
        expiration = newExpiration;
    }

    function claimTimeout() external view {
        require(block.timestamp >= expiration, "Channel not yet expired");
        // selfdestruct(sender);
    }

    function getEthSignedMessageHash(bytes32 messageHash)
        public
        pure
        returns (bytes32)
    {
        return
            keccak256(
                abi.encodePacked(
                    "\x19Ethereum Signed Message:\n32",
                    messageHash
                )
            );
    }

    function recoverSigner(bytes32 ethSignedMessageHash, bytes memory signature)
        public
        pure
        returns (address)
    {
        require(signature.length == 65, "Invalid signature length");

        bytes32 r;
        bytes32 s;
        uint8 v;

        /// @solidity memory-safe-assembly
        assembly {
            r := mload(add(signature, 32))
            s := mload(add(signature, 64))
            v := byte(0, mload(add(signature, 96)))
        }

        return ecrecover(ethSignedMessageHash, v, r, s);
    }
}
