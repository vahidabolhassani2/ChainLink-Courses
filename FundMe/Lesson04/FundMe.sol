//Get funds from users
//Withdraw funds
//Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import {AggregatorV3Interface} from "@chainlink/contracts@1.4.0/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FUndMe {
    // Address(ETH/USD): 0x694AA1769357215DE4FAC081bf1f309aDC325306

    function fund() public payable {
        require(msg.value > 1e18, "not enought fund");
    }

    function getPrice() public {}

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        return priceFeed.version();
    }

    function getConversionRate() public {}
    // function withdraw() {}
}
