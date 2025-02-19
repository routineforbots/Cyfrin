// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol"; 

contract FundMe {

    uint256 public myValue = 10; // variable to showcase how transaction is reverted

    uint256 public minUSD = 5;


// get fund from users into this contract - add keyword payable
function fund() public payable {
    /* functionality:
       1. allow users to send $
       2. have a minimum $ sent 
    */

    /* 
    we can use global keyword msg to access values of the transaction
    and with the keyword require control the minimum amount of funds to be sent + revert message
    
    myValue = myValue + 2;
    require(msg.value >= 1e18, "didn't send enough ETH"); // 1e18 = 1ETH = 1000000000000000000 = 1 * 10 ** 18

    if require() doesn't pass - the whole transaction reverts
    undoes any actions that have been done and send the remaining gas back (myValue will not be +2)
    */

    // we will need to convert current price of Ethereum in USD with Chainlink Oracle
    require(msg.value >= minUSD, "didn't send enough ETH");

}

// we want to get current price of ETH in USD
function getPrice() public view returns (uint256) {
    AggregatorV3Interface pricefeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
   (, int answer, , ,) = pricefeed.latestRoundData(); // we will return only one variable out of 5
    return uint256(answer * 1e10); // we need to convert it to uint256 to match msg.value for the follow-up steps
}


// we want to get the convertion rate
function getConvertion() public view {

}


// withdraw funds back to the owner of the conract
function withdraw() public {

}

// set a minimum funding value in USD



}