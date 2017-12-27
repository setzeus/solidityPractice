pragma solidity ^0.4.9;

// The the largest reason for the existence of ERC223 vs ERC20 is the fallback catch-safe stopping users from sending eth to contracts that aren't designed to function with sent funds
// https://github.com/Dexaran/ERC223-token-standard/blob/Recommended/ERC223_Interface.sol

interface ERC223 {
 uint public totalSupply;
 function balanceOf(address who) constant returns (uint);

 function name() constant returns (string _name);
 function symbol() constant returns (string _symbol);
 function decimals() constant returns (uint8 _decimals);
 function totalSupply() constant returns (uint256 _supply);

 function transfer(address to, uint value) returns (bool ok);
 function transfer(address to, uint value, bytes data) returns (bool ok);
 function transfer(address to, uint value, bytes data, string custom_fallback) returns (bool ok);
 event Transfer(address indexed from, address indexed to, uint value, bytes indexed data);
}
