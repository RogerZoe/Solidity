// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

//SIMPLY USING THE CALLED FUNCTION CONTRACT THROUGH THE CALLING CONTRACT [DATA IS CONTRACT A BUT EXECUTION WILL HAPPEN ACCORDING TO CALLED CONTRACT..............
contract hl0 {
    // Change the function to accept a parameter
    function add(uint _num) public pure returns(uint) {
        return _num * 2; // Use the passed parameter
    }
}

contract Sec {
    uint Num = 32; // This is the value we want to use

    function add(address _contract) public returns(uint) {
        // Call the add function in hl0 with Num as the parameter
        (bool success, bytes memory bt) = _contract.delegatecall(abi.encodeWithSignature("add(uint256)", Num));
        require(success, "Delegatecall failed"); // Ensure the call was successful
        return abi.decode(bt, (uint)); // Decode the returned bytes to uint
    }
}


