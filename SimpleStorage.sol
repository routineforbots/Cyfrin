// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; //stating a version

//range can be defined like that: pragma solidity >=0.8.18 <0.9.0

//contracts are like Class type of objects:
contract SimpleStorage {
    // basic types: 
    // boolean 
    // uint - unsigned integer, positive whole number (no decimal), 
    // int - signed integer, positive/negative whole number 
    // string
    // address
    // bytes

    bool hasFavouriteNumber = true;
    uint favouriteNumber1 = 88; 
    //we can specify how many bits/bytes we want to use for this variable:
    uint256 favouriteNumber2 = 15; //here variable has 256 bits; since it is not explicitly assigned, favouriteNumber0 will also have 256
    int favouriteNumber3 = -1;
    string favouriteNumberInText = "88";
    address myAddress = 0x19efc8Bef97C51646A71da6C336402d78a21b5aD; 
    bytes32 favouriteBytes32 = "cat"; //string objects are actually bytes objects for text
    //bytes and bytesNUMBER (with number specified) are actually different object


    uint256 favouriteNumber; //has default value = 0; any type of object has default value: boolean is false, etc...
    

}

