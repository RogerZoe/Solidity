// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/*
Alice signs a message off-chain allowing Bob to withdraw 1 ETH
But Bob can reuse the same signature multiple times to drain Alice's account!
*/

contract VulnerableBank {
    mapping(address => uint) public balances;
    
    constructor() payable {}
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    
    // ❌ VULNERABLE: No replay protection
    function withdraw(
        address _from,
        address _to,
        uint _amount,
        bytes memory _signature
    ) public {
        // Verify signature
        bytes32 messageHash = getMessageHash(_from, _to, _amount);
        bytes32 ethSignedHash = getEthSignedMessageHash(messageHash);
        
        require(recoverSigner(ethSignedHash, _signature) == _from, "Invalid signature");
        require(balances[_from] >= _amount, "Insufficient balance");
        
        // Transfer funds
        balances[_from] -= _amount;
        balances[_to] += _amount;
    }
    
    function getMessageHash(address _from, address _to, uint _amount) 
        public pure returns (bytes32) 
    {
        return keccak256(abi.encodePacked(_from, _to, _amount));
    }
    
    function getEthSignedMessageHash(bytes32 _messageHash) 
        public pure returns (bytes32) 
    {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _messageHash));
    }
    
    function recoverSigner(bytes32 _ethSignedHash, bytes memory _signature) 
        public pure returns (address) 
    {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(_signature);
        return ecrecover(_ethSignedHash, v, r, s);
    }
    
    function splitSignature(bytes memory sig) 
        public pure returns (bytes32 r, bytes32 s, uint8 v) 
    {
        require(sig.length == 65, "Invalid signature length");
        
        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := byte(0, mload(add(sig, 96)))
        }
    }
}