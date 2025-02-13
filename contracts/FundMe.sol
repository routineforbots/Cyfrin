// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


contract FundMe {

// get fund from users into this contract - add keyword payable
function fund() public payable {
    /* functionality:
       1. allow users to send $
       2. have a minimum $ sent 
    */

    // we can use global keyword msg to access values of the transaction
    // and with the keyword require control the minimum amount of funds to be sent + revert message
    require(msg.value > 1e18, "didn't send enough ETH"); // 1e18 = 1ETH = 1000000000000000000 = 1 * 10 ** 18
    

}




// withdraw funds back to the owner of the conract
function withdraw() public {

}

// set a minimum funding value in USD



}