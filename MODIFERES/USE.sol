// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract hlo {
    uint256 public age;
    uint256 public temp = 12;
    modifier Samecode() {
        uint256 age1 = 12;
        for (uint256 i = 0; i < 5; i++) {
            age = age + i;
        }
        _;
        age = age1 + temp;
    }

    function fun() public Samecode returns (uint256, string memory) {
        age += age;
        return (temp, "hello");
    }

    function fun2() public Samecode returns (uint256, string memory) {
        return (age, "hello");
    }

    function fun3() public Samecode returns (uint256, string memory) {
        return (age, "hello");
    }
}
