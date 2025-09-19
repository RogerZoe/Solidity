// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

// IN THIS CONTRACT WE ARE SENDING EHTER TO ACCOUNT ADDRESS ................
contract SendEth {
    // 👉   Contracts receive ether via payable functions
    // 👉   Contracts send ether via payable addresses
    address payable public Getter =
        payable(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2);

    // TO RECEIVE ETHER............
    receive() external payable {}

    //FUNCTION TO CHECK THE BALANCE......
    function Check() public view returns (uint256) {
        return address(this).balance;
    }

    // ABOVE IS ONLY TO RECEIVE THE ETHER.....

    //FUNCTION TO SEND THE ETHER......
    function Send() public {
        //SYNTAX IS BOOL _NAME = PAYABLE_NAME.SEND(AMOUNT IN WEI);
        //RETURNS BOOL VALUE.......
        bool sent = Getter.send(2000000000000000000);
        // USE REQUIRE(THERE IS NO REVERT OPTION )IF TRANSACTION FAILS..................
        require(sent, "transc Failed");
    }

    //TRANSFER _FUNCTION...........

    function Transfer() public {
        Getter.transfer(2000000000000000000);
    }

    // CALL ==> MOSTLY USED IN SMART CONTRACT (IT HAS REQUIRE AND CUSTOM ETHER OPTION).......

    function Call() public {
        // SYNTAX IS...........
        //  (BOOL _NAME,BYTES STORAGE _NAME)   = PAYABLE_NAME.CALL(VALUE:___,GAS:___}(" ");

        (bool sent, ) = Getter.call{value: 2000000000000000000}("");

        require(sent, "fuck off");
    }
}
