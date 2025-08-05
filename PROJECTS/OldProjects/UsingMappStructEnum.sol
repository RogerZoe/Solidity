// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

// Requirement:
// 1. Store the students' data
// 2. Sort by rank based on marks: pass or fail
// 3. Show the result by RollNO

//Update in Rank...............
contract Help {
    enum RankValue {
        first,
        second,
        third,
        pass,
        fail
    }
    struct studentRecord {
        uint256 rollno;
        string name;
        uint256 TM;
        uint256 math;
        uint256 english;
        uint256 telugu;
        uint256 coding;
        RankValue rank;
    }
   event Note(studentRecord sd);
    mapping(uint256 => studentRecord) public Result;

    function EnterDetails(
        uint256 _rollno,
        string memory _name,
        uint256 _math,
        uint256 _english,
        uint256 _telugu,
        uint256 _coding
    ) public {
        uint256 totalMarks = _math + _english + _telugu + _coding;
        RankValue rank = RankCheck(totalMarks);

        studentRecord memory student = studentRecord({
            rollno: _rollno,
            name: _name,
            TM: totalMarks,
            math: _math,
            english: _english,
            telugu: _telugu,
            coding: _coding,
            rank: rank
        });
        Result[_rollno] = student;
        emit Note(student);
    }

    function PrintResult(uint256 _rollno)  internal view returns (
        uint256 rollno,
        string memory name,
        uint256 totalMarks,
        uint256 math,
        uint256 english,
        uint256 telugu,
        uint256 coding,
        string memory rank
    ) {
        studentRecord memory student = Result[_rollno];
        return (
            student.rollno,
            student.name,
            student.TM,
            student.math,
            student.english,
            student.telugu,
            student.coding,
            RankToString(student.rank)
        );
    }

    function RankCheck(uint256 _tm) internal pure returns (RankValue) {
        if (_tm > 390) {
            return RankValue.first;
        } else if (_tm > 360) {
            return RankValue.second;
        } else if (_tm > 300) {
            return RankValue.third;
        } else if (_tm > 200) {
            return RankValue.pass;
        } else {
            return RankValue.fail;
        }
    }

    function RankToString(RankValue rank) internal pure returns (string memory) {
        if (rank == RankValue.first) {
            return "first";
        } else if (rank == RankValue.second) {
            return "second";
        } else if (rank == RankValue.third) {
            return "third";
        } else if (rank == RankValue.pass) {
            return "pass";
        } else {
            return "fail";
        }
    }
}

//Nested Mapping..........
contract Code {
    mapping(uint256 => mapping(string => uint256)) public User;

    function adduser(
        uint256 _Id,
        string memory _name,
        uint256 _age
    ) public {
        User[_Id][_name] = _age;
    }
}