// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

// SENDING ETHERS FROM ONE TO ANOTHER SMART CONTRACT................

contract SendETH {
    receive() external payable {}

    function checkbal() public view returns (uint256) {
        return address(this).balance;
    }

    // ADD ADDRESS payable GETTER...........
    function Send(address payable Getter) public payable {
        bool sent = Getter.send(msg.value);
        require(sent, "transc Failed");
    }

    function Transfer(address payable Getter) public payable {
        Getter.transfer(msg.value);
    }

    function Call(address payable Getter) public payable {
        (bool sent, ) = Getter.call{value: msg.value}("");
        require(sent, "fuck off");
    }
}

contract Double {
    receive() external payable {}

    function checkbal() public view returns (uint256) {
        return address(this).balance;
    }
}
