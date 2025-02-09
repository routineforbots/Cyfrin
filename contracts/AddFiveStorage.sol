// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// we want to inherit SimpleStorage and extend its functionality by adding +5 to the variable
import {SimpleStorage} from './SimpleStorage02.sol';

// define contract as a child of another one a
contract AddFiveStorage is SimpleStorage  {
    function sayHello() public pure returns(string memory) {
        return "Hi!";
    }
    // overrides keyword - change behaviour of initial store() function from the SimpleStorage contract
    // function in initial contract SimpleStorage must have keyword vurtual - means it can be overridden
    function store(uint256 _newNumber) public override {
        myFavoriteNumber = _newNumber + 5;
    }
}