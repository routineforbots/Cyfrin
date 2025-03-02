// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    // this is how we attach library to specific data type
    using PriceConverter for uint256; 
    // because function has uint256 as a parameter: getConvertionRate(uint256 _ethAmount)

    uint256 public myValue = 10;
    uint256 public minUSD = 5 * (10 ** 18); 
    address[] public funders;
    mapping(address funder => uint256 amountFunded ) public addressToAmountFunded;

    address public owner;

// cunstructor is this function is a function which is called at the time of deployment of the contract
// we will use it to assign creator of the contract as its owner
constructor() {
    owner = msg.sender;

}


function fund() public payable {
    // require(getConvertionRate(msg.value) >= minUSD, "didn't send enough ETH");
    require(msg.value.getConvertionRate() >= minUSD, "didn't send enough ETH");
    // if getConvertionRate will have 2 parameters getConvertionRate(uint256 _ethAmount, uint256 _someThing)
    // then we will call it like that: msg.value.getConvertionRate(123), where msg.value is the 1st parameter and 123 is the 2nd

    funders.push(msg.sender);
    // addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value; 
    addressToAmountFunded[msg.sender] += msg.value; //alternative version of the above code
}


// withdraw funds back to the owner of the conract; onlyOwner here is the modifier used to add functionality
function withdraw() public onlyOwner {
    // modifier will be called first - so it will check if owner == caller of the function

    /*
    for loop
    [1, 2, 3, 4] - elements
     0, 1, 2, 3  - indexes
    */
    for (/* starting index, ending index, step amount */ uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
        address funderAddress = funders[funderIndex];
        addressToAmountFunded[funderAddress] = 0;
    }

    // we will reset the array by creating new one
    funders = new address[](0); // (0) - means starting length of array equals zero


    /* 
    There are 3 ways to send funds in ETH:
    1. transfer
    2. send
    3. call
    

    // 1. transfer - it is capped at 2300 gas and if more gas is used it throws an error
    payable(msg.sender).transfer(address(this).balance); 

    Keyword this reffers to this whole contract
    We also need to cast msg.sender from address type to payable address type
    Transfer will automatically revert the transaction in case of an error.
    

    // 2. send - also capped at 2300 gas and if it fails it returns bool
    bool sendSuccess = payable(msg.sender).send(address(this).balance);
    require(sendSuccess, "Failed to send"); // this is the way we rever the transaction since send doesn't do this

    */

    // 3. call - low level command to call any function without knowing ABI, doesn't have capped gas and returns bool
    (bool callSuccess, /* bytes memory dataReturned */) = payable(msg.sender).call{value: address(this).balance}(""); // this function returns 2 variables but we only need a first one
    require(callSuccess, "Call failed"); // again we rever the transaction since call doesn't do this


}

// modifier allows us to create a keyword which we can put in the function declaration to add some functionality
// can be used for repeated functionality
modifier onlyOwner() {
    // _; - place defines the order: if we put it here then function will be called first and the the modifier bellow:
    require(msg.sender == owner, "Not authorized, only owner can call it");
    _; // code of the function will be called after modifier if this _; is placed at the end
}


}