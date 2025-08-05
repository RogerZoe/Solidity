// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VerifySignature {
    // Step 1: Hash the original message (like "hello")
    function getHash(string memory _message) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_message));
    }

    // Step 2: Hash it again with Ethereum's signed message prefix
    function getEthSignedHash(bytes32 _messageHash)
        public
        pure
        returns (bytes32)
    {
        return
            keccak256(
                abi.encodePacked(
                    "\x19Ethereum Signed Message:\n32",
                    _messageHash
                )
            );
    }

    // Step 3: Recover the address that signed the message
    function verify(bytes32 _ethSignedMessageHash, bytes memory _signature)
        public
        pure
        returns (address)
    {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    // Split the signature into r, s, v (needed for ecrecover)
    function splitSignature(bytes memory sig)
        public
        pure
        returns (
            bytes32 r,
            bytes32 s,
            uint8 v
        )
    {
        require(sig.length == 65, "Invalid signature length");

        assembly {
            // first 32 bytes
            r := mload(add(sig, 32))
            // second 32 bytes
            s := mload(add(sig, 64))
            // final byte (first byte of next 32 bytes)
            v := byte(0, mload(add(sig, 96)))
        }
    }

    function isValidSignature(
        address expectedSigner,
        string memory message,
        bytes memory signature
    ) public pure returns (bool) {
        bytes32 messageHash = getHash(message);
        bytes32 ethSignedMessageHash = getEthSignedHash(messageHash);

        return verify(ethSignedMessageHash, signature) == expectedSigner;
    }
}

// ==> In Console
// const hash = "0x27b51e338b39ef89a07380cbe86e7d437143327a99b0d8ca445b62856ae93382";
// const account = "0xB1d8DBA0B902E36c58d5c8AC50061Ab3aA5cD3e5";

// await ethereum.request({ method: "eth_requestAccounts" });

// const signature = await ethereum.request({
//   method: "personal_sign",
//   params: [hash, account.toLowerCase()],
// });

// console.log("✅ Signature:", signature);
