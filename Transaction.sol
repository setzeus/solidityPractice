pragma solidity ^0.4.9;

contract Transaction {
    // each contract has an ethereum address - it can be found with: address(this)

    event SenderLogger(address);
    event ValueLogger(uint);

    address private owner;

    modifier isOwner {
        require(owner==msg.sender);
        _;
    }

     modifier validValue {
        require(msg.value >= 1);
        _;
    }

    function Transaction() {
        owner = msg.sender;
    }

    //payable is a modifier that can be added to any function
    //payable is a reserved keyword that allows a contract to receive ether
    // a contract can have exactly one unnamed function, it is default executed if contract is called w  no parms
    function () payable isOwner validValue {
        SenderLogger(msg.sender);
        ValueLogger(msg.value);
    }
}
