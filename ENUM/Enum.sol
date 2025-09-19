// SPDX-License-Identifier: MIT

// ==> PURPOSE  OF INDICATING THAT UNDER WHICH LICENSE NUMBER THE CODE IS RELEASED

pragma solidity ^0.8.0;

contract Enum {
    enum status {
        pending,
        success,
        cancel,
        reject
    }
    status set; //  CREATING  VALUES WITH ENUM DATATYPES.......

    function hlo() public view returns (status) {
        return set;
    }

    function setstatus(status _set) public {
        set = _set; //  UPDATE OR CHANGE
    }

    function rej() public {
        set = status.reject; // here WE WRITE LIKE STATUS.REJECT NOT LIKE SET.REJECT.........
    }

    function check() public view returns (status) {
        return set;
    }

    function del() public {
        delete set;
    }
}

//  Yes, in Solidity, enums are not directly compared to integers. Instead, you compare them using their enum values.
// However, you can initialize enum values using integers in the constructor or any other function by casting the integer to the enum type.

contract Help {
    enum Rank {
        First,
        Second,
        Third
    }

    Rank public rank;

    // Constructor to set the initial rank
    constructor(uint256 _initialRank) {
        require(_initialRank <= uint256(Rank.Third), "Invalid rank");
        rank = Rank(_initialRank);
    }
    function setRank(uint256 _rank) public {
        require(_rank <= uint256(Rank.Third), "Invalid rank");
        rank = Rank(_rank);
    }
    function checkStatus() public view returns (string memory) {
        if (rank == Rank.First) {
            return "First Rank";
        } else if (rank == Rank.Second) {
            return "Second Rank";
        } else if (rank == Rank.Third) {
            return "Third Rank";
        } else {
            return "Rank not set";
        }
    }
}
