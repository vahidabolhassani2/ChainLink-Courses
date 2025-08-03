// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {AggregatorV3Interface} from "@chainlink/contracts@1.4.0/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
        function getPrice() internal  view returns (uint256) {
        //ETH interms of USD
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (, int256 answer, , , ) = priceFeed.latestRoundData();

        uint8 weiPower = 18;
        return uint256(answer) * 10**(weiPower - priceFeed.decimals());
    }

    function getVersion() internal  view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        return priceFeed.version();
    }

    /*
     * Converts input ETH to USD
     */
    function getConversionRate(uint256 ethAmount)
        internal 
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

}