pragma solidity ^0.4.9;

// No "random" function like in other languages.
// Below are a few mediocre, not real randomization ways of circumventing.
// Best way of accomplishing this is with Oraclizing off-chain: https://github.com/oraclize/ethereum-examples

contract unsafeRandomPractice {

  function unsafeRandomByBlochHas() public returns (uint) {
    return uint(block.blockhash(block.number-1)) % 100;
  }

  uint private _baseIncrement;

  //worst possible of doing this - eats up gas
  function unsafeIncrementByRandom() public returns (uint) {
    return uint(sha3(_baseIncrement++)) % 100;
  }
}
