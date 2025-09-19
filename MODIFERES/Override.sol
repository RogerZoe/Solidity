// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

// Modifiers can be overridden in a similar way to how functions can be overridden..............
contract Check {
    uint256 num = 12;
    modifier Che() virtual {
        require(num < 10, "not correct");
        _;
    }
}

contract Exec is Check {
    uint num2=13;
    modifier Che() override {
        require(num > 10, " correct");
        _;
    }
}
