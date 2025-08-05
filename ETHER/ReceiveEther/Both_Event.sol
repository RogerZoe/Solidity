// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

// Define a contract named `hlo`
contract hlo {
    
    // Define an event named `Log` that will be emitted in fallback and receive functions.
    // This event logs the function name, sender's address, value sent, and any data passed.
    event Log(string _fun, address _sender, uint256 _val, bytes _data);

    // Define a fallback function that is executed when the contract receives a call with data 
    // that doesn't match any function signature or if Ether is sent with data that doesn't 
    // match the `receive` function. The fallback function is marked as `payable` to accept Ether.
    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value, msg.data);  // Emit the Log event with details.
    }

    // Define a receive function that is executed when the contract receives Ether without any data.
    // This function is automatically called when Ether is sent directly to the contract address.
    receive() external payable {
        emit Log("receive", msg.sender, msg.value, " ");  // Emit the Log event without any data.
    }

    // Define a function named `Chek` that returns the balance of the contract.
    // The `view` modifier indicates that this function does not modify the state.
    function Chek() public view returns (uint256) {
        return address(this).balance;  // Return the current Ether balance of the contract.
    }
}



// Use receive to accept Ether when no data is sent.
// Use fallback to handle unexpected or incorrect calls and optionally accept Ether.
// Use payable in specific functions where you expect to receive Ether as part of the function’s execution, such as in deposit functions.
