pragma solidity ^0.4.9;

// Main point of using interfaces (or abstract contracts) is provide re-useable, custom contracts. In this example
// the interface specifies the functions a contract of type TokenInterface must implement to fit into the overall application framework

// https://github.com/ethereum/EIPs/issues/20
// compare this to other interface standard within directory (ERC223)
//https://github.com/Dexaran/ERC223-token-standard/blob/Recommended/ERC223_Interface.sol

interface ERC20 {
  function transferFrom(address _from, address _to, uint _value) returns (bool success);
  function approve(address _spender, uint _value) returns (bool success);
  function allowance(address _owner, address _spender) constant returns (uint remaining);
  function balanceOf(address _owner) constant returns (uint balance);
  function totalSupply() constant returns (uint totalSupply);
  function transfer(address _to, uint _value) returns (bool success);
  event Approval(address indexed _owner, address indexed _spender, uint _value);
  event Transfer(address indexed _from, address indexed _to, uint _value);
}
