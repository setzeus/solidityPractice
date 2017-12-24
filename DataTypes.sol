pragma solidity ^0.4.9;

contract DataTypes {
    
    bool myBool = false;
    
    //has to be divisible by 8, can be - 128 to 127
    int8 myInt = -128;
    
    // 0 - 255
    uint8 myUint = 255;
    
    string myString;
    uint8[] myStringArr;
    
    //string is actually an array of values
    // you cannot pass an array of strings because an array of strings constains a nested array
    
    byte myValue;
    // 1 - 32 
    bytes1 myBytes1;
    bytes2 myBytes2;
    
    //fixed point number - something to use in financial system
    //floating point number - something to use in geometry 

    enum Action {ADD, REMOVE, UPDATE}
    Action myAction = Action.ADD;
    address myAddress;
    
    function assignAddress() {
        myAddress = msg.sender;
        myAddress.balance;
        myAddress.transfer(10);
    }
    
    uint[] myIntArr = [1,2,3];
    
    function arrayFunc() {
        myIntArr.push(1);
        myIntArr.length;
        myIntArr[0];
    }
    
    uint[10] myFixedArr; //this would get an out of bounds if pushed another value
    
    // a struct is an "object with no functionality"
    struct Account {
        uint balance;
        uint dailyLimit;
    }
    
    Account myAccount;
    
    function structFunc() {
        myAccount.balance = 100;
    }
    
    //hash map, map, or a dictionary
    mapping (address => Account) _accounts;
    
    function ()  payable{
        _accounts[msg.sender].balance += msg.value;
    }
    
    function getBalance() returns (uint) {
        return _accounts[msg.sender].balance;
    }
    
}
