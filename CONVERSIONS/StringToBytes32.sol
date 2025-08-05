pragma solidity ^0.8.0;

contract StringToBytes32 {
    function stringToBytes32(string memory _string) public pure returns (bytes32) {
        bytes32 result;
        assembly {
            result := mload(add(_string, 32))
        }
        return result;
    }
}
