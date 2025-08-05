// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

library Math {
    function sum(uint256 num1, uint256 num2)external pure returns (uint256) // IF I USE INTERNAL OR PUBLIC THEN DIRECTLY I CAN ACCESS LIKE CONTRACT NAME.FUNCTION NAME;
    {
        return num1 + num2;
    }
}

contract hlo {
    using Math for uint256;

    //EXTERNAL PURPOSE.By "using"==> using MathLib for uint; , you're telling the Solidity compiler that you want to associate the functions of the MathLib library with the uint data type.
    // This means that you can call the library's functions directly on any uint variable as if those functions were methods of the uint type.
    function result(uint256 num1, uint256 num2) public pure returns (uint256) {
        uint256 ans = Math.sum(num1, num2);
        return ans;
    }
}
