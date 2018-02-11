pragma solidity ^0.4.18;

contract Owned {
    address owner;

    function Owned() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
}

contract setBlocks is Owned {

    struct userTest {
        uint age;
        bytes16 fName;
        bytes16 lName;
    }

    mapping(address => userTest) userTests;

    address[] public userTestsAccts;

    event userInfo(
        bytes16 fName,
        bytes16 lName,
        uint age
    );

    function setUserTest(address _address, uint _age, bytes16 _fName, bytes16 _lName) onlyOwner public {
        var userTest = userTests[_address];

        userTest.age = _age;
        userTest.fName = _fName;
        userTest.lName = _lName;

        userTestsAccts.push(_address) -1;
        userInfo(_fName,_lName,_age);
    }

    function getUsers() view public returns(address[]) {
        return userTestsAccts;
    }

    function getUser(address _findUser) view public returns(uint, bytes16, bytes16) {
        return (userTests[_findUser].age,userTests[_findUser].fName,userTests[_findUser].lName);
    }

}
