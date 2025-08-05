// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SwimmersClub {
    function get(string memory str1, string memory str2) public  pure  returns (string memory)
    {
        bytes memory B = bytes(str2);
        bytes memory A = bytes(str1);
        string memory ans = new string(A.length + B.length);
        // bytes memory _ans=new bytes(ans);  here not creating ,only converting thats why remove " NEW"
        bytes memory _ans = bytes(ans);
        uint256 k = 0;
        for (uint256 i = 0; i < A.length; i++) {
            _ans[k++] = A[i];
        }
        _ans[k++]=" ";
        for (uint256 i = 0; i < B.length; i++) {
            _ans[k++] = B[i];
        }
        return string(_ans);
    }
}
