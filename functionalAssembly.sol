pragma solidity ^0.4.9;

// gas costs are phenomenally low for assembly functions but not at all recommended since very few people know assembly

contract functionalAssembly {

    function nativeLoops() public returns (uint _r) {
        for (uint i=0;i<10;i++) {
            _r++;
        }
    }

    function asmLoop() public returns (uint _r) {
        assembly {
            let i:= 0
            loop:
            i := add(i,1)
            _r := add(_r,1)
            jumpi(loop, lt(i,10))
        }
    }

    function nativeConditional(uint _v) public returns (uint) {
        if(5 == _v) {
            return 55;
        } else if (6 == _v) {
            return 66;
        }
        return 11;
    }
}
