// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract Hlo {
    uint public  num=12;
    uint public constant numConstant =19;
    uint public immutable numImmutable = 56;

    function changes() public {
        num++;
        // numConstant++;
        // numImmutable++;
    }
}

