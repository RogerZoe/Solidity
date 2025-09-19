// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// It lets each Ethereum account (user) maintain their own personal address book on-chain, storing:
// a list of other Ethereum addresses they care about

// an alias (nickname) for each of those addresses
// So it is like a personal contacts list on the blockchain.

contract AddressBook {
    mapping(address => address[]) private _allowedListedAddresses;
    mapping(address => mapping(address => string)) private _ownerToNickname;

    function add(address _address, string memory _alias) public {
        _allowedListedAddresses[msg.sender].push(_address);
        _ownerToNickname[msg.sender][_address] = _alias;
    }

    function getAlias(address owner, address addr)
        public
        view
        returns (string memory)
    {
        require(bytes(_ownerToNickname[owner][addr]).length!=0,"No Address available");
        return _ownerToNickname[owner][addr];
    }

    function removeAdd(address addr) public {
        for (uint256 i = 0; i < _allowedListedAddresses[msg.sender].length; ) {
            uint length=_allowedListedAddresses[msg.sender].length;
            if (_allowedListedAddresses[msg.sender][i] == addr) {
                if (i < length - 1) {
                    _allowedListedAddresses[msg.sender][i] = _allowedListedAddresses[msg.sender][length - 1];
                }
                _allowedListedAddresses[msg.sender].pop();
                delete _ownerToNickname[msg.sender][addr];
                break;
            }
            unchecked{++i;}
        }
    }
}
