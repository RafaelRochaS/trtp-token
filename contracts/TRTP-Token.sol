// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

contract TRTPToken {
    string public name = "Tretas Pesadas Token";
    string public symbol = "TRTP";
    uint8 public decimals = 4;
    uint public totalSupply = 0;
    mapping(address => uint) private balance;
    
    struct SpendingAllowance {
        address owner;
        address spender;
        uint value;
    }
    SpendingAllowance[] private allowances;

    event Transfer(address indexed from, address indexed to, uint value);

    function balanceOf(address owner) public view returns (uint) {
        return balance[owner];
    }

    function transfer(address to, uint value) public returns (bool success) {
        require(balance[msg.sender] >= value, "Not enough balance in account");
        balance[msg.sender] -= value;
        balance[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    // function transferFrom(address from, address to, uint value) public returns (bool success) 
    // }

    function aprove(address spender, uint value) public returns (bool success) {
        // Check if msg.sender is in array, if so update, else create as below
        SpendingAllowance memory allowance = SpendingAllowance({owner: msg.sender, spender: spender, value: value});
        allowances.push(allowance);
        return true;
    }

    function findIdOfAddress(address addr) private view returns (uint) { // TODO: Better error handling
        for (uint i = 0; i <= allowances.length; i++) {
            if (allowances[i].owner == addr) {
                return i;
            }
        }
        return 999999;  // TODO: Better way - via error handling
    }
}