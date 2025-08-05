// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract fun {
    uint256 public num = 12;

    // INSIDE THE CONTRACT

    function fuck() public view returns (
            uint256    //MORE  GAS THAN PURE
        )
    {
        return num;
    }

    function fuck2(uint256 num1, uint256 num2) public pure returns (uint256) {
        return num1 * num2;
    }
}

// OUSIDE THE CONTRACT  ,DOESNT APPEAR  BECAUSE BY DEFAULT IT IS INTERNAL

function out(uint256 x) pure returns (uint256) {
    return x;
}
