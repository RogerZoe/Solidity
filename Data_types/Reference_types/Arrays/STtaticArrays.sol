// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Operations {
    uint256[7] public arr2 = [1, 23, 4, 2, 5, 4];

    // RETURN THE VALUE AT PARTICULAR INDEX

    function getvalue(uint256 i) public view returns (uint256) {
        return arr2[i];
    }

    function getvalue1(uint256 i) public {
        arr2[i] = 23; // update value

        uint256 temp;
        temp = arr2[2]; //get

        delete arr2[4]; //delete
    }

    function getvalue2() public view returns (uint256[7] memory) {
        return arr2; // return an array.........
    }
}

//  MOSTLY AVOID RETURNNIG AN ARRAY DUE TO GAS COST..........

contract ArrayInfun {
    /* 1.*/
    function set(uint256[4] memory arr)
        public
        pure
        returns (uint256[4] memory)
    {
        return arr;
    }

    /* 2.*/
    function set2() public pure returns (uint256[] memory) {
        uint256[] memory temp = new uint256[](4);
        return temp;
    }
}
