// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Example {
    uint256 x = 12;
    address public Owner;

    constructor(address _owner) {
        Owner = _owner;
    }

    function Hlo(uint256 _x) public view returns (uint256) {
        require(_x != 0, "fuck off");
        return x + _x;
    }
}

contract E1 {
    uint256 y = 12;
    Example public Ex; 

    constructor() {
        Ex = new Example(msg.sender);
    }

    event MSG(string msg);

    function hlo() public returns (uint256) {
        try Ex.Hlo(y) {
            emit MSG("close Call");
        } catch {
            emit MSG("failed");
        }
        uint256 ans = Ex.Hlo(y);
        return ans;
    }
}
