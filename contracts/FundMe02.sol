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



function fund() public payable {
    // require(getConvertionRate(msg.value) >= minUSD, "didn't send enough ETH");
    require(msg.value.getConvertionRate() >= minUSD, "didn't send enough ETH");
    // if getConvertionRate will have 2 parameters getConvertionRate(uint256 _ethAmount, uint256 _someThing)
    // then we will call it like that: msg.value.getConvertionRate(123), where msg.value is the 1st parameter and 123 is the 2nd

    funders.push(msg.sender);
    // addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value; 
    addressToAmountFunded[msg.sender] += msg.value; //alternative version of the above code
}


// withdraw funds back to the owner of the conract
function withdraw() public {
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
    funders = new address[](0); // (0) - means starting length equals zero


    // withdraw the funds
    


}




}