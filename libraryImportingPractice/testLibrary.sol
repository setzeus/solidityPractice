pragma solidity ^0.4.8;

import "browser/library.sol";

contract testLibrary {
    using IntExtended for uint;

    function testDecrement(uint _base) returns (uint) {
        return IntExtended.decrement(_base);
    }

    function testDecrementByValue(uint _base, uint _value) returns (uint) {
        return _base.decrementByValue(_value);
    }

    function testIncrement(uint _base) returns (uint) {
        return IntExtended.increment(_base);
    }

    function testIncrementByValue(uint _base, uint _value) returns (uint) {
        return _base.incrementByValue(_value);
    }
}
