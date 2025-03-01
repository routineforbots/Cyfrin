// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// before 0.8.x of Solidity there is a concept of unchecked variables which can be illustrated like that:

contract SafeMathTester {

    uint8 public bigNumber = 255; // 255 is the max number which uint8 data type can store


    function add() public {
        // bigNumber = bigNumber + 1; 
        // for solidity < 0.8.0 the first run will reset 255 to 0 and each following run will increase it + 1

        // in Solidity 0.8.x that was fixed but it if needed this can be reverted with the keyword "unchecked"
        unchecked {bigNumber = bigNumber + 1;}

    } 



}

