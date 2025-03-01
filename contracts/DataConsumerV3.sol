// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// importing from npm package manager which downloads from github
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol"; 


/*
concept in Solidity know as Interface - collection of functions of a contract without knowing implementation details:
    
interface AggregatorV3Interface {
    function decimals() external view returns (uint8);

    function description() external view returns (string memory);

    function version() external view returns (uint256);

    function getRoundData(
        uint80 _roundId
    ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

    function latestRoundData()
        external
        view
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}

so now we call functions from the interface:

function getVersion() public view returns (uint256){
    return AggregatorV3Interface(0x694A1769357215DE4FAC081bf1f309aDC325306).version();
    // contract 0x694A1769357215DE4FAC081bf1f309aDC325306 is being used to create an instace of the AggregatorV3Interface contract
    // which defines set of functions that must be implemented by another contract
}
*/



contract DataConsumerV3 {
    AggregatorV3Interface internal dataFeed;

    /**
     * Network: Sepolia
     * Aggregator: BTC/USD
     * Address: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
     */
    constructor() {
        dataFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
    }

    /**
     * Returns the latest answer.
     */
    function getChainlinkDataFeedLatestAnswer() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer; 
        // decimals don't work in solidity so the output is one long number: 271823761251

    }

    // we must also check the decimal flag to understand where to put a dot: 2718.23761251
    function getDecimals() external view returns (uint8) {
        (
            uint8 decimal
        )= dataFeed.decimals();
        return decimal;
    
    }

   
}
