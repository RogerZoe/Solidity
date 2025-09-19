// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Example {
    // State variable x initialized to 12
    uint256 x = 12;

    // Public state variable to store the owner's address
    address public Owner;

    // Constructor that sets the owner of the contract
    constructor(address _owner) {
        Owner = _owner;
    }

    // Function Hlo that takes a uint256 argument and returns uint256
    // It requires that the input _x is not zero, or it will revert with an error message
    function Hlo(uint256 _x) public view returns (uint256) {
        require(_x != 0, "fuck off"); // Reverts if _x is 0
        return x + _x; // Returns the sum of x and _x
    }
}

contract E1 {
    // State variable y initialized to 12
    uint256 y = 12;

    // Public state variable to store an instance of the Example contract
    Example public Ex;

    // Constructor that creates a new instance of the Example contract
    constructor() {
        Ex = new Example(msg.sender);
    }

    // Event that logs a message
    event MSG(string msg);

    // Function hlo that attempts to call the Hlo function in the Example contract
    function hlo() public returns (uint256) {
        // Using try/catch to handle any errors when calling Hlo function
        try Ex.Hlo(y) {
            emit MSG("close Call"); // Emits a message if the call succeeds
        } catch {
            emit MSG("failed"); // Emits a message if the call fails
        }

        // Calls Hlo function again and stores the result in ans
        uint256 ans = Ex.Hlo(y);
        return ans; // Returns the result
    }
}

//ANOTHER EXAMPLE..................

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// External contract used for try / catch examples
contract Foo {
    address public owner;

    constructor(address _owner) {
        require(_owner != address(0), "invalid address");
        assert(_owner != 0x0000000000000000000000000000000000000001);
        owner = _owner;
    }

    function myFunc(uint256 x) public pure returns (string memory) {
        require(x != 0, "require failed");
        return "my func was called";
    }
}

contract Bar {
    event Log(string message);
    event LogBytes(bytes data);

    Foo public foo;

    constructor() {
        // This Foo contract is used for example of try catch with external call
        foo = new Foo(msg.sender);
    }

    // Example of try / catch with external call
    // tryCatchExternalCall(0) => Log("external call failed")
    // tryCatchExternalCall(1) => Log("my func was called")
    function tryCatchExternalCall(uint256 _i) public {
        try foo.myFunc(_i) returns (string memory result) {
            emit Log(result);
        } catch {
            emit Log("external call failed");
        }
    }

    // Example of try / catch with contract creation
    // tryCatchNewContract(0x0000000000000000000000000000000000000000) => Log("invalid address")
    // tryCatchNewContract(0x0000000000000000000000000000000000000001) => LogBytes("")
    // tryCatchNewContract(0x0000000000000000000000000000000000000002) => Log("Foo created")
    function tryCatchNewContract(address _owner) public {
        try new Foo(_owner) returns (Foo foo) {
            // you can use variable foo here
            emit Log("Foo created");
        } catch Error(string memory reason) {
            // catch failing revert() and require()
            emit Log(reason);
        } catch (bytes memory reason) {
            // catch failing assert()
            emit LogBytes(reason);
        }
    }
}
