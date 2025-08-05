// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Simple {
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }
}

contract Factory {
    bytes32 public salt = bytes32(uint256(123));

    function deploy() external returns (address) {
         return address(new Simple{salt: salt}(msg.sender));  // ==> THIS IS THE ACTUAL ADDRESS OF CONTRACT SIMPLE // 0x5F16bB68BDF67aD18144a2b042832c60Dd37fF23
    }

    function getBytecode(address _owner) public pure returns (bytes memory) {
        return abi.encodePacked(type(Simple).creationCode, abi.encode(_owner));
    }

    function getAddress(bytes memory bytecode)
        public
        view
        returns (
            address // => THIS IS THE PREDICTED ADDRESS , // 0x5F16bB68BDF67aD18144a2b042832c60Dd37fF23
        )
    {
        return
            address(
                uint160(
                    uint256(
                        keccak256(
                            abi.encodePacked(
                                bytes1(0xff),
                                address(this),
                                salt,
                                keccak256(bytecode)
                            )
                        )
                    )
                )
            );
    }
}
