// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// simple way to import - will import everything from this file
// import './SimpleStorage02.sol';

// named import performs a fine-grainded import - very professional way!!!
import {SimpleStorage, SimpleStorage2} from './SimpleStorage02.sol';


contract StorageFactory{    
    // type - visibility - name notation to declare a variable
    // SimpleStorage public simpleStorage;
    
    //but instead of previouse step lets create a list of all instances of SimpleStorage contract that will be created 
    SimpleStorage[] public listOfSimpleStorageContracts; //previous version


    function createSimpleStorageContract () public {
        // new keyword means to create an instace of SimpleStorage contract and assign it to simpleStorage variable
        // simpleStorage = new SimpleStorage(); 

        // version for list of all instances
        SimpleStorage newSimpleStorageContract = new SimpleStorage();
        //listOfSimpleStorageContracts.push(newSimpleStorageContract);
        listOfSimpleStorageContracts.push(newSimpleStorageContract);
    }
    // function which stores variable in created instance of SimpleStorage
    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorage) public {
        // to interact with the other contract we need its ABI & Address OR function selector (will cover this later)
        // ABI - Application Binary Interface

        // lets get a specific instance from our list of created ones to save variable in our _newSimpleStorage which we have just updated 
        listOfSimpleStorageContracts[_simpleStorageIndex].store(_newSimpleStorage);// using inherited function store() 

    }
    // to a saved variable from the specific instance of SimpleStorage
    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        return listOfSimpleStorageContracts[_simpleStorageIndex].retrieve(); // using inherited function retrieve()
    
    }

}