// SPDX-License-Identifier: MIT

// ==> PURPOSE  OF INDICATING THAT UNDER WHICH LICENSE NUMBER THE CODE IS RELEASED

pragma solidity ^0.8.0;

contract hlo {
    struct Porn {
        uint256 members;
        string genre;
        address location;
    }
    Porn p1; // IF YOU WANT MORE OBJECTS THEN MORE VARIBALES TO CREATE IT SO THAT WE CAN REPRESENT IT........................
    Porn p2;

    //  THREE WAYS TO INTIALIZE THE STRUCT..........

    // Method 1:" Inline Initialization "
    function create() public {
        p1 = Porn(2, "milf", 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4); // variable_name=data_type
        p2 = Porn(3, "milf", 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4); // variable_name=data_type
    }

    //Method 2: Named Arguments Initialization
    function creat2() public {
        p1 = Porn({
            members: 3,
            genre: "gangbang",
            location: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
        });
        p2 = Porn({
            members: 5,
            genre: "gangbang",
            location: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
        });
    }

    //Method 3: Individual Member Assignment

    function creat3() public {
        p1.genre = "stepmom";
        p1.members = 2;
        p2.genre = "japanese";
    }

    // ACCESSSING

    function get() public view returns (string memory) {
        return p1.genre;
    }
}
