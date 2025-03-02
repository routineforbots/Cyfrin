// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {PriceConverter} from "./PriceConverter.sol";

// we will optimize gas with the use of Solidity's Custom Errors
error NotOwner();


// we will also  adjust valiables for gas optimization with keywords:
//The immutable keyword allows values to be set at runtime, while the constant keyword requires values to be set at compile time.
// const - initialized once and can be reassigned within a scope, should be ALL_CAPITAL letters
// immutable - initialized once remain unchanged, should start with i_*

contract FundMe {
    using PriceConverter for uint256; 

    uint256 public constant MY_VALUE = 10; // constant
    uint256 public constant MINIMUM_USD = 5 * (10 ** 18); // constant

    address[] public funders;
    mapping(address funder => uint256 amountFunded ) public addressToAmountFunded;

    address public immutable i_owner; // immutable


constructor() {
    i_owner = msg.sender;

}


function fund() public payable {
    require(msg.value.getConvertionRate() >= MINIMUM_USD, "didn't send enough ETH");

    funders.push(msg.sender);
    addressToAmountFunded[msg.sender] += msg.value; 
}


function withdraw() public onlyOwner {

    for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
        address funderAddress = funders[funderIndex];
        addressToAmountFunded[funderAddress] = 0;
    }

    funders = new address[](0); 

    (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}(""); 
    require(callSuccess, "Call failed"); 


}


modifier onlyOwner() {
    // require(msg.sender == i_owner, "Not authorized, only owner can call it");
    if(msg.sender != i_owner) { revert NotOwner(); }
    _;
}

// What happens if someone sends this contract ETH without calling the fund function? We can use special functions to deal with that

// receive() - if someone will send us money directly without calling fund() function
receive() external payable {
    fund();
 }

// fallback() - if someone will call a contract with wrong function
fallback() external payable {
    fund();
}
}