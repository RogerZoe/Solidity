// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract fix {
    bytes5 public num = 0x1233223135;
    bytes5 public temp;

    //Both Are Same........................
    bytes4 public fixedArray = hex"01020304";
    bytes4 public fixedArray2 = 0x01020304;

    constructor(bytes5 _temp) {
        temp = _temp;
    }

    function ret() public view returns (bytes5) {
        return temp[3]; //we can access bytes via index because bytes are nothing but a suquence of stored 1bytes[8 bit values
    }

    function len() public view returns (uint256) {
        return temp.length;
    }

    bytes4 public sum = "acde";

    function hlo() public view returns (string memory) {
        return string(abi.encodePacked(sum)); //string representation............
    }
}
