// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Arrays_Intro {
    uint256[4] public arr;
    uint256[7] public arr2 = [1, 23, 4, 2, 5, 4];

    string[3] public str = ["as0", "sf", "sfssdf"];
    address[4] public ad;

    function get() public view returns (uint256[4] memory) {
        return arr;
    }

    function get1() public view returns (uint256[7] memory) {
        return arr2;
    }

    function get2() public view returns (string[3] memory) {
        return str;
    }

    function get3() public view returns (address[4] memory) {
        return ad;
    }

    function examples() external pure {
        uint256[] memory a = new uint256[](5); // -->> Memory arrays are useful when you need to create temporary arrays within a function.
    }
}
