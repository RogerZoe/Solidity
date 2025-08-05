// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Lottery {
    address public Manager; //lottery manager ............
    address payable[] public participants; // after the contest ,we need to send the ether to the winner for that we use payable and array type[].........

    //when this contract will compiled thenn,who needs to control this contract [manager]

    constructor() {
        Manager = msg.sender; //global variable
    }

    // to receive ether .........to the contract
    receive()
        external
        payable
    //By making it external, the compiler ensures that it cannot be invoked from within the contract itself, as its purpose is to handle incoming ether transfers from external sources.
    {
        require(msg.value == 2 ether);
        participants.push(payable(msg.sender)); //shows that this address had received the ethers......
    }

    //to check the balance
    function Checkbal() public view returns (uint256) {
        require(msg.sender == Manager);
        return address(this).balance;
    }

    function Random() public view returns (uint256) {
        return
            uint256(
                keccak256(
                    abi.encodePacked(
                        block.difficulty,
                        block.timestamp,
                        participants.length
                    )
                )
            );
    }

    //REAL FUN BEGINS NOW.............

    // function Winner_select() public  view returns(address)
    // {

    //      require(msg.sender==Manager);
    //      require(participants.length>=3);
    //     uint get=Random();
    //      uint index=get % participants.length;
    //      address payable winner;     //address payable is used to declare the winner variable as an address type ==> [that can receive ether]. Since the winner will receive the prize money, their address needs to be of type payable.
    //      winner=participants[index];
    //      return winner;

    // }

    function Winner_select() public {
        require(msg.sender == Manager);
        require(participants.length >= 3);
        uint256 get = Random();
        uint256 index = get % participants.length;
        address payable winner; //address payable is used to declare the winner variable as an address type ==> [that can receive ether]. Since the winner will receive the prize money, their address needs to be of type payable.
        winner = participants[index];
        // we need store the money into the winners account..
        winner.transfer(Checkbal());
    }
}
