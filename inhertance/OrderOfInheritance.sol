// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract first {
    function hello() virtual view public returns(uint) {
        return 1;
    }
}

contract Second {
    function hello() virtual view public returns(uint) {
        return 2;
    }
}

contract third is first, Second {
    function hello() public view override(first, Second) returns(uint) {
        // This will call Second.hello() because Second is the last in the inheritance order.
        return super.hello();
    }
}

// If we reverse the order in the inheritance and override, it will change the behavior.
contract thirdReversed is Second, first {
    function hello() public view override(Second, first) returns(uint) {
        // This will call first.hello() because first is the last in the inheritance order.
        return super.hello();
    }
}
