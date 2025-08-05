// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract check {
    uint256 private x = 12;
    uint256 public y = 13;
    uint256 internal z = 14;

    //   uint external a=123;   ERROR...............

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

    function checkall() public view returns (uint256) {
        return z; //RETURN ANY VALUE
    }

    function checka() public pure returns (string memory) {
        return check3(); //RETURN ANY VALUE , BUT IF WE WRITE CHECK4 () THEN ERROR .............
    }
}
