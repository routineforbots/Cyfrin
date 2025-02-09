// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24; //stating a version

//range can be defined like that: pragma solidity >=0.8.18 <0.9.0

//contracts are like Class type of objects in other programming languages:
contract SimpleStorage {
    /*
     basic types: 
    boolean 
    uint - unsigned integer, positive whole number (no decimal), 
    int - signed integer, positive/negative whole number 
    string
    address
    bytes
    */

    bool hasFavouriteNumber = true;
    uint favouriteNumber1 = 88; 
    //we can specify how many bits/bytes we want to use for this variable:
    uint256 favouriteNumber2 = 15; //here variable has 256 bits; since it is not explicitly assigned, favouriteNumber0 will also have 256
    int favouriteNumber3 = -1;
    string favouriteNumberInText = "88";
    address myAddress = 0x19efc8Bef97C51646A71da6C336402d78a21b5aD; 
    bytes32 favouriteBytes32 = "cat"; //string objects are actually bytes objects for text
    //bytes and bytesNUMBER (with number specified) are actually different object

    uint256 public myFavouriteNumber; //has default value = 0; any type of object has default value: boolean is false, etc...
    /*
    visibility of the variable is set to internal by default which can be changed with public keyword
    internal - only visible internally, for child contracts and inherited contracts
    public - visible externaly & internally, creates getter function for storage/state variables
    private - only visible in the current contract
    external - for functions only, can only be message-called via this.func
    */

    
    //The following function will update our favouriteNumber; parameters which we will pass to the functions are defined inside ()
    function store(uint256 _favoriteNumber) public { //name of the variables in parameters must be different
        myFavouriteNumber = _favoriteNumber;
    } 

    /*
    Every time when we update state of the blockchain - it costs gas. 
    To not send transaction but just a call (not use gas) we can use view & pure
    Keyword view - function will only read state from the blockchain
    */

    function retrieve() public view returns(uint256){
        return myFavouriteNumber;
    }
    //Function with pure keyword don't allow even reading from blockchain storage (where all variables are stored)
    function retrive_pure() public pure returns(uint256) {
        return 7;
    }

    //The array
    uint256[] mylist;
    //  0.  1.  2.  - indexes
    // [77, 78, 90]

    //mapping works like a "key-value" dictionary
    mapping(string => uint256) public nameToFavoriteNumber; //key is a string => which points to uint256


    //With the struct keyword you can create your own type
    struct Person{
        uint256 favouriteNumber;
        string name;
    }

    //creating a variable of custom type Person
    Person public pat = Person(7, "Pat"); // another form of declaration = Person({favouriteNumber: 7, name: "Pat"})

    //let's create a list/array of persons, Person[] - declaration of type of variable
    Person[] public listOfPeople; // default value of this list will be empty list 
    
    /*
    Array types:
    Person[] - is a dynamic array which grows and shrinks based on amount of elements
    Person[3] - static array with size for 3 elements
    */

    //Function to add people to the array 
    function addPeople(string memory _name, uint256 _favouriteNumber) public {
        /*
        one of the examples how to add a new element of the array:
        Person memory newPerson = Person(_favouriteNumber, _name);
        listOfPeople.push(newPerson);
        */

        //But better way to define it is the following:
        listOfPeople.push(Person(_favouriteNumber, _name));
        nameToFavoriteNumber[_name] = _favouriteNumber; //performing mapping of value (also know as hash table)
    }
    /* Keyword memory means a location of the data which EVM can:
    1. Write & Read from: Stack, Memory, Storage, Calldata, Transient Storage, Code, Returndata
    2. Write only to: Logs
    3. Read only from: Chain Data, Transaction data (&Blobhash), Gas data, Program Counter, etc

    Calldata & memory - are temporarly variables. Differences: memory variable can be changes but calldata is not
    All functions variables are temporary ones
    Calldata & memory means that this variable is going to exist and be available temporarly (=duration of function call)
    Inside of functions most variables are defined as memory ones, 
    Structs, maps & strings are special types - array of bytes - so they must be defined explicitly (because of memory management specifics)
    
    Storage - permanent variable that can be modified
    Any variable declared outside of a function is defined as storage one
    */
    
}

