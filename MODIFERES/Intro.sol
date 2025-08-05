// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

//  MODIFIERS CAN CHANGE THE FUNCTION BEHAVIOUR.....

contract Hlo {
    // MODIFER WITH ARGUMENTS...............
    uint256 public num = 12;
    modifier Col(uint256 _num) {
        require(_num < 20, "fuck off");
        _;
    }
    function Get(uint256 _num) public Col(_num) {
        num = _num;
    }
}


contract Sec {
    // MODIFIER WITHOUT ARGUMENT...........
    uint256 public num = 12;

    modifier Col() {
        require(num < 10, "fuck off");
        _;
    }

    function Get(uint256 _num) public Col {
        num = _num;
    }
}

contract Both {
    // MULTIPLE MODIFIERS............

    struct Student {uint256 no;string name;uint256 age;}

    Student s1;

    modifier Check(uint256 _age) {
        require(_age > 10, "fuck off");
        _;
    }
    modifier Check2(uint256 _no) {
        require(_no < 5, "check the condition");
        _;
    }

    function Get(
        uint256 no,
        string memory name,
        uint256 age
    ) public Check(age) Check2(no) {
        s1.age = age;
        s1.name = name;
        s1.no = no;
    }
}
