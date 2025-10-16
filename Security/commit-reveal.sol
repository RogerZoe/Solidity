// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract SecureVoting {
    // Phase 1: Commit Phase
    mapping(address => bytes32) public commitments;

    // Phase 2: Reveal Phase
    mapping(address => uint256) public votes;

    uint256 public commitDeadline;
    uint256 public revealDeadline;

    constructor(uint256 _commitDuration, uint256 _revealDuration) {
        commitDeadline = block.timestamp + _commitDuration;
        revealDeadline = commitDeadline + _revealDuration;
    }

    function computeCommitment(uint256 _candidateId, bytes32 _secret)
        public
        view
        returns (bytes32)
    {
        return keccak256(abi.encodePacked(msg.sender, _candidateId, _secret));
    }

    // PHASE 1: COMMIT (User submits hash)
    function commitVote(bytes32 _commitment) public {
        require(block.timestamp < commitDeadline, "Commit phase over");
        commitments[msg.sender] = _commitment;
        // At this point, NO ONE knows what you voted for!
    }

    // PHASE 2: REVEAL (User reveals actual vote + secret)
    function revealVote(uint256 _candidateId, bytes32 _secret) public {
        require(block.timestamp >= commitDeadline, "Still in commit phase");
        require(block.timestamp < revealDeadline, "Reveal phase over");

        // Verify the commitment matches
        bytes32 commitment = keccak256(
            abi.encodePacked(msg.sender, _candidateId, _secret)
        );
        require(commitment == commitments[msg.sender], "Invalid reveal");

        // Now record the actual vote
        votes[msg.sender] = _candidateId;
    }
}
