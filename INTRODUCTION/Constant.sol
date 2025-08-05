// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ConstantUsageArrays {
    // Constant array of integers
    int256 constant INTEGER_ARRAY = 43;
    int[3] constant num=[1,2,3,4];

    // Constant array of addresses

    // Solidity only supports constant values of elementary types (value types) and byte array types.
    // Arrays of integers and addresses are not directly supported as constant values.
    // SO DONT WRITE BELOW LIKE CODE
    //address[2] constant  ADDRESS_ARRAY = [0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2];

       address constant name=0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

}
pragma solidity ^0.8.0;

contract ConstantUsageBytes {
    // Constant bytes
    bytes32 constant BYTE_CONSTANT = hex"00112233445566778899aabbccddeeff";
}

pragma solidity ^0.8.0;

contract ConstantUsageEnums {
    // Enumeration
    enum Color { Red, Green, Blue }

    // Constant enum value
    Color constant DEFAULT_COLOR = Color.Blue;
}
pragma solidity ^0.8.0;

contract ConstantUsageMapping {
    // Mapping with constant key and value
    mapping(uint256 => string) constant ID_TO_NAME = {
        1: "Alice",
        2: "Bob",
        3: "Charlie"
    };
}



