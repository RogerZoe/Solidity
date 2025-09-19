// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract hlo {
    string public name = "arif";

    // HERE GIVES WARNING BECAUSE In Solidity version 0.8.0 and later,
    //functions are required to specify their state mutability explicitly using the view or pure keywords if they do not modify the contract's state.
    //  ==> the memory keyword is used for temporary storage inside functions. It tells the Ethereum Virtual Machine (EVM) that a variable should be stored in memory rather than storage.
    function fun() public pure returns (string memory) {
        string memory name1 = "shaik"; //When you declare a variable inside a function without specifying a location, it defaults to storage [mostly for Value types ]. For reference types like strings and array ...., using storage would mean modifying the state of the contract, which could be expensive in terms of gas.
        return name1;
    }

    //to Concate the Strings...............
    function getName(string memory _lastName)
        public
        pure
        returns (string memory)
    {
        string memory initial = "Shaik";
        string memory fullName = string(
            abi.encodePacked(_lastName, " ", initial)
        );
        return fullName;
    }
}

//  pragma solidity ^0.8.0;

// contract hlo {
//     string public name = "arif";

//     function fun() public pure {
//         string memory name1 = "shaik";
//     }
// }

//  return string(abi.encodePacked(_name,_sex));   concatenate two strings...........

contract EscapeSequencesExample {
    string public doubleQuoteString =
        'This is a string with a double quote: "Inside double quotes"';
    string public singleQuoteString =
        "This is a string with a single quote: 'Inside single quotes'";
    string public newLineString =
        "This string starts \n on a new line.New line text.";
    string public backslashString = "A backslash looks like this: \\";
    string public tabString = "Tabbed\tText";
    string public carriageReturnString = "Carriage\rReturn";
    string public hexEscapeString = "Hex Escape: \x41\x42"; // Represents "AB"
    string public unicodeEscapeString = "Unicode Escape: \u0041\u0042"; // Represents "AB"
}

// String in Storage: Acts as a reference type.
// String in Memory: Acts as a reference type, but assignments create a copy.
