// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

// UNDERSTAND SEQUENTIALLY [ACCOUNT ADDRESS]

// This contract demonstrates different ways to send Ether to another address using send, transfer, and call methods.
contract First {
    // Declaring a payable address variable named `Owner`.
    // This address will receive Ether from the contract.
    address payable public Owner = payable(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);

    // The receive function allows the contract to accept Ether sent to it directly.
    receive() external payable {}

    // Function to send 1 Ether using the `send` method.
    // The `send` method returns a boolean indicating success or failure.
    function Send() public {
        bool temp = Owner.send(1000000000000000000); // Sending 1 Ether to the Owner
        require(temp, "Not Successful"); // Reverts if the send fails
    }

    // Function to send 1 Ether using the `transfer` method.
    // The `transfer` method automatically reverts if the transfer fails.
    function Trans() public {
        Owner.transfer(1000000000000000000); // Transferring 1 Ether to the Owner
    }

    // Function to send 1 Ether using the `call` method.
    // The `call` method is low-level and returns a boolean indicating success or failure.
    function call() public {
        // Sending 1 Ether using call with an empty data payload.
        (bool temp, ) = Owner.call{value: 1000000000000000000}("");
        require(temp, "Transaction failed"); // Reverts if the call fails
    }
}

// This contract demonstrates how to send Ether to a dynamically provided address.
// The user can specify the recipient's address when calling the functions.
contract Second {
    // The receive function allows the contract to accept Ether sent to it directly.
    receive() external payable {}

    // Function to send 1 Ether using the `send` method to a user-provided address.
    function Send(address payable Owner) public {
        bool temp = Owner.send(1000000000000000000); // Sending 1 Ether to the provided address
        require(temp, "Not Successful"); // Reverts if the send fails
    }

    // Function to send 1 Ether using the `transfer` method to a user-provided address.
    function Trans(address payable Owner) public {
        Owner.transfer(1000000000000000000); // Transferring 1 Ether to the provided address
    }

    // Function to send 1 Ether using the `call` method to a user-provided address.
    function call(address payable Owner) public {
        // Sending 1 Ether using call to the provided address with an empty data payload.
        (bool temp, ) = Owner.call{value: 9000000000000000000}("");
        require(temp, "Transaction failed"); // Reverts if the call fails
    }
}

// This contract demonstrates how to receive and send Ether simultaneously.
// The function must be `payable` to accept and forward Ether in the same transaction.
contract THIRD {

    // The receive function allows the contract to accept Ether sent to it directly.
    receive() external payable {}

    // Function to receive Ether and immediately send it to a provided address using `send`.
    function Send(address payable Owner) public payable {
        bool temp = Owner.send(msg.value); // Sending the received Ether to the provided address
        require(temp, "Not Successful"); // Reverts if the send fails
    }

    // Function to receive Ether and immediately send it to a provided address using `transfer`.
    function Trans(address payable Owner) public payable {
        Owner.transfer(msg.value); // Transferring the received Ether to the provided address
    }

    // Function to receive Ether and immediately send it to a provided address using `call`.
    function call(address payable Owner) public payable {
        // Sending the received Ether using call to the provided address with an empty data payload.
        (bool temp, ) = Owner.call{value: msg.value}("");
        require(temp, "Transaction failed"); // Reverts if the call fails
    }
}

// This contract is an example of a simple contract that can receive Ether.
// The `receive` function allows it to accept Ether directly.
contract GetEth {
    receive() external payable {}
}
