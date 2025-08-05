// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// USING ONLY BY ARRAYS..........................
contract SmartRanking {
    struct Student {
        uint256 rollNumber;
        uint256 marks;
    }

    Student[] public students;

    uint256 public studentCount;
    uint256 public highestMarks;

    // This function is used to insert the marks
    function insertMarks(uint256 _rollNumber, uint256 _marks) public {
        // Check if student already exists with the given roll number
        for (uint256 i = 0; i < students.length; i++) {
            require(students[i].rollNumber != _rollNumber,"Marks for this roll number already inserted");
        }

        // Add the student to the array
        students.push(Student(_rollNumber, _marks));
        studentCount++;

        // Update highestMarks if necessary
        if (_marks > highestMarks) {
            highestMarks = _marks;
        }
    }

    // This function returns the highest marks obtained by a student
    function topperMarks() public view returns (uint256) {
        require(students.length > 0, "No students have inserted marks yet");
        return highestMarks;
    }
}
