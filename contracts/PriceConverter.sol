// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol"; 

// for library we need to change visiability of all functions from public -> internal

library PriceConverter {
   
    function getPrice() internal view returns (uint256) {
        AggregatorV3Interface pricefeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int answer, , ,) = pricefeed.latestRoundData(); 
        return uint256(answer * 1e10);
    }

    function getConvertionRate(uint256 _ethAmount) internal view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (_ethAmount * ethPrice) / 1e18; 
        return ethAmountInUsd;

    }

    function getVersion() internal view returns (uint256) {
        // return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
        
        // different address is used for ZKSync
        return AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF).version();
    }
}