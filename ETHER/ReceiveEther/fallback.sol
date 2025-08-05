// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

// fallback is a special function that is executed either when a function that does not exist is called or
// Ether is sent directly to a contract but receive() does not exist or msg.data is not empty
// fallback has a 2300 gas limit when called by transfer or send.

contract hlo1 {
    event Hlo(address, uint256);

    //  RECEIVE DATA(BYTES) AND EHTERS...............
    fallback() external payable {
        emit Hlo(msg.sender, msg.value);
    }

    receive() external payable {}

    function get() public view returns (uint256) {
        return address(this).balance;
    }
}
