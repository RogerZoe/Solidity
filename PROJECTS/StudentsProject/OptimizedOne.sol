// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract SmartRanking {
    struct Student {
        uint256 marks;
        bool exists;
    }

    mapping(uint256 => Student) public results;
    uint256  topperMarks;
    uint256  topperRollNumber;

    function insertMarks(uint256 _rollNumber, uint256 _marks) public {
        require(!results[_rollNumber].exists, "Marks for this roll number already inserted");

        results[_rollNumber].marks = _marks;
        results[_rollNumber].exists = true;

        if (_marks > topperMarks) {
            topperMarks = _marks;
            topperRollNumber = _rollNumber;
        }
    }

    function topperMarks1() public view returns (uint256) {
        require(results[topperRollNumber].exists, "No students have inserted marks yet");
        return topperMarks;
    }

    function topperRollNumber1() public view returns (uint256) {
        require(results[topperRollNumber].exists, "No students have inserted marks yet");
        return topperRollNumber;
    }
}
