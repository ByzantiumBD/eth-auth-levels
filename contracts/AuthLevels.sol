// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.18;



contract AuthLevel {
    //address owner allows address "allowed" to do operations with certain auth levels
    //Auth levels have been implemented as bytes, where you have:
    //00000000 is not authorized at all
    //00000001 is authed for level 1
    //00000100 is authed for level 4 **only**
    //00000101 is authed for 1, 4 and 5
    mapping(address => mapping(address => uint8)) public auths;

    function authorize(
        address owner, 
        address allowed, 
        uint8 level
    ) public {
        auths[owner][allowed] = level;
    }

    modifier requireAuth(address owner, uint8 level) {
        require(level & auths[owner][msg.sender] == level, "Not authorized");

        _;
    }
}

contract Example is AuthLevel {
    mapping(address => uint8) counter;

    function addAmount(address owner, uint8 amount) public requireAuth(owner, amount) {
        unchecked {
            counter[owner] += amount;
        }
    }
}