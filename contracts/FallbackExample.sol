// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


// What happens if someone sends this contract ETH without calling the fund function? We can use special functions to deal with that

// receive() - Is specifically designed to receive Ether (ETH) and execute some logic when called directly with ETH value transfer = if calldata is empty.
// newer alternative to fallback()

// fallback() - Executes when there's no matching function call on the contract = if calldata is NOT empty.
// so if you call a contract with wrong function

/*
                 send Ether
                      |
           msg.data is empty?
                /           \
            yes             no
             |                |
    receive() exists?     fallback()
        /        \
     yes          no
      |            |
  receive()     fallback()
  
*/



contract FallbackExample {
    uint256 public fallback_result;
    uint256 public receive_result;


    // special functions definition

    receive() external payable {
        receive_result = 10;

     }

    fallback() external payable {
        fallback_result = 10;
     }
}