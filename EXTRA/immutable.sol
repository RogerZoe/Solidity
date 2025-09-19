// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Hello {

    uint public immutable hlo; // Value set in the constructor
    uint public constant HLO = 10; // Value fixed at compile time
    constructor(uint _hlo) {
        hlo = _hlo;
    }
    // ==> immutable has more Gas Cost than constant ;
}
