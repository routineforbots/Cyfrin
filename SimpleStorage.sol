// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; //stating a version

//range can be defined like that: pragma solidity >=0.8.18 <0.9.0

//contracts are like Class type of objects in other programming languages:
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

    uint256 public favouriteNumber; //has default value = 0; any type of object has default value: boolean is false, etc...
    //visibility of the variable is set to internal by default which can be changed with public keyword
    //internal - only visible internally, for child contracts and inherited contracts
    //public - visible externaly & internally, creates getter function for storage/state variables
    //private - only visible in the current contract
    //external - for functions only, can only be message-called via this.func

    
    //The following function will update our favouriteNumber; parameters which we will pass to the functions are defined inside ()
    function store(uint256 _favoriteNumber) public { //name of the variables in parameters must be different
        favouriteNumber = _favoriteNumber;
    } 

    //Every time when we update state of the blockchain - it costs gas. 
    //To not send transaction but just a call (not use gas) we can use view & pure
    //Keyword view - function will only read state from the blockchain
    function retrieve() public view returns(uint256){
        return favouriteNumber;
    }
    //Function with pure keyword don't allow even reading from blockchain storage (where all variables are stored)
    function retrive_pure() public pure returns(uint256) {
        return 7;
    }
}

