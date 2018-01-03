pragma solidity ^0.4.9;

// practicing inheritance & polymorphism by printing out an "alphabet" initialized
// of contract characters built differently

// requiring that our alphabet characters output some integer by creating a contract interface
interface Letter {
  function n() public returns (uint);
}

// first letter contract "A", returns 1
contract A is Letter {
    function n() public returns (uint) {
        return 1;
    }
}

// second letter contract "B" returns 2 & additionally has it's own return function
contract B is Letter {
    function n() public returns (uint) {
        return 2;
    }

    function x() public returns (string) {
        return "x";
    }
}

// third letter contract "C" that's an initialized version of contract "A"
contract C is A {
  //note that this doesn't required the n() function defined in other initializations
  //this is because that function is already defined in contract "A"
}

contract Alphabet {

    //create an array of Letters (or references to Letter interface)?
    Letter[] private letters;

    function Alphabet() public {
        letters.push(new A());
        letters.push(new B());
        letters.push(new C());
    }

    function printLetters() public {
        for(uint i = 0; i < letters.length; i++) {
            Printer(letters[i].n());
        }
    }
}
