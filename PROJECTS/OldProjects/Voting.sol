// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Voting {
    enum Candidates_names {
        jagan,
        KCR,
        Naidu,
        PK
    }
    mapping(Candidates_names => uint256) public VoteCounts;

    event Castvote(address voter, Candidates_names _candi);

    struct Voters {
        uint256 voter_Id;
        uint256 start_time;
        uint256 end_time;
        uint256 age;
        mapping(address => bool) hasVoted;
    }
    mapping(uint256 => Voters) public voters;

    function CreatVote(
        uint256 voter_id,
        uint256 _endTime,
        uint256 _age
    ) public {
        voters[voter_id].start_time = block.timestamp;
        voters[voter_id].end_time = voters[voter_id].start_time + _endTime;
        voters[voter_id].age = _age;
    }

    function CastVote(uint256 _voter_Id, uint256 options) public {
        require(
            voters[_voter_Id].hasVoted[msg.sender] == false,
            " you already voted "
        );
        require(voters[_voter_Id].end_time > block.timestamp, " time Expired");
        require(voters[_voter_Id].age > 18, " Age is Out of Bounds");

        if (options == uint256(Candidates_names.jagan)) {
            VoteCounts[Candidates_names.jagan]++;
            voters[_voter_Id].hasVoted[msg.sender] = true;
            emit Castvote(msg.sender, Candidates_names.jagan);
        } else if (options == uint256(Candidates_names.KCR)) {
            VoteCounts[Candidates_names.KCR]++;
            voters[_voter_Id].hasVoted[msg.sender] = true;
            emit Castvote(msg.sender, Candidates_names.KCR);
        } else if (options == uint256(Candidates_names.Naidu)) {
            VoteCounts[Candidates_names.Naidu]++;
            voters[_voter_Id].hasVoted[msg.sender] = true;
            emit Castvote(msg.sender, Candidates_names.Naidu);
        } else if (options == uint256(Candidates_names.PK)) {
            VoteCounts[Candidates_names.PK]++;
            voters[_voter_Id].hasVoted[msg.sender] = true;
            emit Castvote(msg.sender, Candidates_names.PK);
        }
    }

    function determineWinner() public view returns (string memory winnername) {
        uint256 maxVotes = 0;
        Candidates_names winner;
        for (uint256 i = 0; i < uint256(Candidates_names.PK) + 1; i++) {
            Candidates_names candidate = Candidates_names(i);
            if (VoteCounts[candidate] > maxVotes) {
                maxVotes = VoteCounts[candidate];
                winner = candidate;
            }
        }
        if (winner == Candidates_names.jagan) {
            winnername = "jagan";
        } else if (winner == Candidates_names.KCR) {
            winnername = "KCR";
        } else if (winner == Candidates_names.Naidu) {
            winnername = "Naidu";
        } else if (winner == Candidates_names.PK) {
            winnername = "PK";
        }
    }
}
