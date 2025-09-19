// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

 
// USING ARRAY + MAPPING.................................
contract SmartRanking {
    struct Student {
        uint256 marks;
    }

    mapping(uint256 => Student) public Result;
    uint256 public studentCount;
    uint256[] public rollNumbers;
    uint rollnumber;

    //this function is used to insert the marks
    function insertMarks(uint256 _rollNumber, uint256 _marks) public {
        // Check if student already exists with the given roll number
        require(
            Result[_rollNumber].marks == 0,
            "Marks for this roll number already inserted"
        );
        Result[_rollNumber].marks = _marks;
        rollNumbers.push(_rollNumber);
        studentCount++;
    }

    //this function returns the hightest marks obtained by student
    function topperMarks() public   returns (uint256) {
        require(rollNumbers.length > 0, "No students have inserted marks yet");

        uint256 highestMarks = 0;

        // Iterate over the rollNumbers array to find the student with the highest marks
        for (uint256 i = 0; i < rollNumbers.length; i++) {
            uint256 rollNumber = rollNumbers[i];
            if (Result[rollNumber].marks > highestMarks) {
                highestMarks = Result[rollNumber].marks;
                rollnumber=rollNumber;
            }
        }

        return highestMarks;
    }

    //this function returns the roll number of student having highest marks
    function topperRollNumber() public view  returns (uint256) {
                return rollnumber;
    }
}
