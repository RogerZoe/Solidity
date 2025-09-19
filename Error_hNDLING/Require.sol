// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract HLo {
    uint256 public num = 123;
    address public owner = msg.sender;

    // INPUT/OUPUT VALIDATION ....................
    function cHck() public returns (bool) {
        require(num < 1234, "ushfhshf");
        num = num + num;
        return true;
    }

    // ACCESS CONTROL...................
    function add() public {
        require(msg.sender == owner, "you are not the owner");
        num = num - 23;
    }
}
