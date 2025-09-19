// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract dyn {
    bytes public num; // we cant intialize here............
    // **Dynamic-Size Types**: Because their size can change, Solidity can't allocate a fixed amount of space for them at the contract deployment time.
    //  Initializing them directly in the contract would require complex handling, which is why it's not allowed

    constructor() {
        num = "123abcdef";
    }

    function help() public {
        num.push("c");
    }
}
