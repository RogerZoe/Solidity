// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/Strings.sol";
contract BinaryConverter {
    // Function to convert decimal to binary
    function decimalToBinary(uint256 num) public pure returns (uint256[] memory) {
        uint256[] memory binary = new uint256[](256); // Maximum length assumed
        uint256 id = 0;

        // Number should be positive
        while (num > 0) {
            binary[id++] = num % 2;
            num = num / 2;
        }

        // Trim array to actual size
        uint256[] memory result = new uint256[](id);
        for (uint256 i = 0; i < id; i++) {
            result[i] = binary[id - i - 1]; // Reverse the binary array
        }

        return result;
    }
}
contract ToBinary{

		function toBinary(uint256 num) public pure  returns (string memory ) {

        if (num == 0) {
            return "0";
        }
        
        uint256 temp = num;
        string memory binary;
        
        while (temp > 0) {
            uint256 rem = temp % 2;
            binary = string(abi.encodePacked(Strings.toString(rem), binary)); // Rememb
            temp = temp / 2;
        }
        return binary;
        }
}

