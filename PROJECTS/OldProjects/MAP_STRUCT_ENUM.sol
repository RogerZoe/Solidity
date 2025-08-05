// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MyContract {
    enum Vote_Status {
        Pending,
        Active,
        Ended
    }

    struct Vote {
        string name;
        uint256 start_time;
        uint256 end_time;
        mapping(address => bool) hasVoted;
        uint256 yes_votes;
        uint256 no_votes;
        Vote_Status status;
    }

    Vote[] members;
    mapping(uint256 => Vote) public votes;
    uint256 public nextVoteId;

    // TO CREATE A VOTE..........
    function createVote(string memory _name, uint256 duration) public {
        uint256 endTime = block.timestamp + duration;
        votes[nextVoteId].name = _name;
        votes[nextVoteId].start_time = block.timestamp;
        votes[nextVoteId].end_time = endTime;
        nextVoteId++;
    }

    function castVote(uint256 _voteId, bool _vote) public {
        if (_vote) {
            votes[_voteId].yes_votes++;
        } else {
            votes[_voteId].no_votes++;
        }

        votes[_voteId].hasVoted[msg.sender] = true;
    }

    function gettheVote(uint256 vote_id) public view returns (string memory,uint256,uint256,uint256,uint256,Vote_Status)
    {
        Vote storage vot = votes[vote_id];
        return (
            vot.name,
            vot.start_time,
            vot.end_time,
            vot.yes_votes,
            vot.no_votes,
            vot.status
        );
    }
}