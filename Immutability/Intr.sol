// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract Hlo {
    // uint public immutable age;
    address public immutable add; // So, address(2) is a shorthand for an address like 0x0000000000000000000000000000000000000002
    address public constant cons = address(1);
    address public simp = address(1);

    // uint public constant aage2; // THIS GIVES ERROR ,THAT MEANS AT THE TIME OF DECLRATION ONLY INTIALIZE IT...........

    // WE CAN INITIALIZE BY USING CONSTRUCTOR...........
    constructor(address _add) {
        add = _add;
    }

    function I() public view returns (address) {
        return add;
    }

    function C() public pure returns (address) {
        return cons;
    }

    function S() public view returns (address) {
        return simp;
    }
}
