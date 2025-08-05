// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract checkchild {
    uint256 private x = 12;
    uint256 public y = 13;
    uint256 internal z = 14;

    function check1() public pure returns (string memory) {
        return "public";
    }

    function check2() private pure returns (string memory) {
        return "private"; // IT NOT SHOWS THE BUTTON BECAUSE PRIVATE IS WITHIN THE CONTRACT ,BUT BUTTON IS OUTSIDE THE WORLD
    }

    function check3() internal pure returns (string memory) {
        return "internal"; // SAME AS PRIVATE;
    }

    function check4() external pure returns (string memory) {
        return "external"; //  ONLY OUTSIDE THE CONTRACT
    }
}

// contract A is checkchild {
//     // uint a=x;  THIS GIVES ERROR ,BECAUSE IT SHOULD BE WITHIN THE CONTRACT.
//     uint256 a = y;
//     uint256 b = z;

//     string ab = check1();
//     //  string ba=check2(); // ERROR..............
//     string ba = check3();
//     string bab;

//     // string bab = this.check4(); // OUSIDE THE CONTRACT .need to write (this) because it  triggers an external call through the EVM.
//     //reason: external functions expect calldata and an external message call

//     constructor() {
//         bab = this.check4(); // safe here, contract is deployed
//     }
// }

contract A is checkchild {
    uint256 a = y;
    uint256 b = z;

    string ab = check1();
    string ba = check3();
    string bab;

    constructor() {
        bab = "external cannot be called here"; // fallback
    }

    function setBab() public {
        bab = this.check4();
    }

    function getBab() public view returns (string memory) {
        return bab;
    }
}


contract c {
    A obj = new A(); // creating object
    uint256 public a = obj.y();

    function anotherCaller() public view returns (string memory) {
        return obj.check4(); // FOR 2 AND 3 ERROR.....................
    }
}
