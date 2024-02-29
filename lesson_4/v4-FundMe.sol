// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {PriceConverter} from './v2-PriceConverter.sol';

// let's perform a gas optimisation (current tx cost: 745605)
// for that we will use keywords: constant and immutable (see bellow the usage)


contract FundMe {
    using PriceConverter for uint256; 

    address[] public funders;

    uint256 public constant MINIMUM_USD = 5e18; // now the tx cost is 725869

    address public immutable i_owner; // now the tx cost is 702674

    constructor() {
        i_owner = msg.sender;
    }

    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;


    function fund() public payable {
        require(msg.value.getConversionRate() > MINIMUM_USD, "did not send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value; 

    }


   function withdraw() public onlyOwner {

    for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++ ) {
        address funder = funders[funderIndex];
        addressToAmountFunded[funder] = 0;
    }

    funders = new address[](0);

    (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}(""); 
    require(callSuccess, "Send failed");

   }

   modifier onlyOwner() {
    require(msg.sender == i_owner, "Sender is not the owner");
    _; 
   }


}