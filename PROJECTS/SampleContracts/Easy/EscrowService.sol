// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Allow two parties to agree off-chain and authorize a transaction on-chain only when both have approved. 
// This is done via a custom smart contract = abstracted account logic.

contract EscrowService {
    
    struct EscrowAccount {
        uint256 balance;
        address buyer;
        address seller;
        bool buyerApproved;
        bool sellerApproved;
    }

    // Each escrow is tied to a unique ID
    mapping (uint256 => EscrowAccount) public escrows;
    uint256 public escrowId;

    // Create a new escrow account
    function createEscrowAccount(address _buyer, address _seller) external payable {
        require(msg.value > 0, "Escrow must have value");

        escrowId++;
        escrows[escrowId] = EscrowAccount({
            balance: msg.value,
            buyer: _buyer,
            seller: _seller,
            buyerApproved: false,
            sellerApproved: false
        });
    }

    // Buyer or seller approves the transaction
    function approveTransaction(uint256 _escrowId) external {
        EscrowAccount storage escrow = escrows[_escrowId];
        require(msg.sender == escrow.buyer || msg.sender == escrow.seller, "Not authorized");

        if (msg.sender == escrow.buyer) {
            escrow.buyerApproved = true;
        } else if (msg.sender == escrow.seller) {
            escrow.sellerApproved = true;
        }

        // If both approved, release funds to seller
        if (escrow.buyerApproved && escrow.sellerApproved) {
            uint256 amount = escrow.balance;
            escrow.balance = 0;

            (bool success, ) = payable(escrow.seller).call{value: amount}("");
            require(success, "Transfer failed");
        }
    }

    // Allow buyer to cancel escrow if seller doesn’t approve (not implemented here but could be added)
}
