// SPDX-License-Identifier: MIT

// ==> PURPOSE  OF INDICATING THAT UNDER WHICH LICENSE NUMBER THE CODE IS RELEASED

pragma solidity ^0.8.0;

contract hlo {
    struct Porn {
        uint256 members;
        string genre;
        address location;
    }
    Porn[] public p1;

    function create() public pure {
        Porn memory pornstar1 = Porn(
            1,
            "milf",
            0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
        );
        Porn memory Pornstar2 = Porn(
            2,
            "stepmom",
            0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
        );
    }

    function creat2() public pure {
        Porn memory pornstr1 = Porn({
            members: 3,
            genre: "gangbang",
            location: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
        });
        Porn memory pornstr2 = Porn({
            members: 5,
            genre: "gangbang",
            location: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
        });
    }

    //Method 3: Individual Member Assignment
    // PUHSING VALUES INTO THE ARRAY.....>

    function creat3() public {
        Porn memory pornstr1 = Porn({
            members: 3,
            genre: "gangbang",
            location: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
        });
        Porn memory pornstr2 = Porn({
            members: 5,
            genre: "gangbang",
            location: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
        });
        Porn memory temp;
        temp.genre = "stepmom";
        temp.members = 2;
        p1.push(pornstr1);
        p1.push(pornstr2);
        p1.push(temp);
    }
}
