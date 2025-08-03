//Get funds from users
//Withdraw funds
//Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import {AggregatorV3Interface} from "@chainlink/contracts@1.4.0/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FUndMe {
    // Address(ETH/USD): 0x694AA1769357215DE4FAC081bf1f309aDC325306
    uint256 public minimumUsd = 50 * 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable {
        require(
            getConversionRate(
                msg.value /*in wei*/
            ) >= minimumUsd,
            "Didn't send enough"
        );
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function getPrice() public view returns (uint256) {
        //ETH interms of USD
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (, int256 answer, , , ) = priceFeed.latestRoundData();

        uint8 weiPower = 18;
        return uint256(answer) * 10**(weiPower - priceFeed.decimals());
    }

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        return priceFeed.version();
    }

    /*
     * Converts input ETH to USD
     */
    function getConversionRate(uint256 ethAmount)
        public
        view
        returns (uint256)
    {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18; //ethPrice*ethAmount has 36 0's
        return ethAmountInUsd;
        /*
         *example:
         * ethPrice = 3000 USD = 3000_000000000000000000 (in wei)
         * ethAmount = 1 ETH = 1_000000000000000000 (in wei)
         * ethAmountInUsd = 3000_000000000000000000
         */
    }
    // function withdraw() {}
}
