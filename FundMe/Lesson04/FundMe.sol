//Get funds from users
//Withdraw funds
//Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "./PriceConverter.sol";

// Address(ETH/USD): 0x694AA1769357215DE4FAC081bf1f309aDC325306
contract FUndMe {
    using PriceConverter for uint256;

    uint256 public minimumUsd = 50 * 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable {
        require(
            msg.value.getConversionRate() >= minimumUsd, /*in wei*/
            "Didn't send enough"
        );
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public {
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        /*
         * type of msg.sender: address
         * type of payable(msg.sender): payable address
         */

        /*
         *payable(msg.sender).transfer(address(this).balance); //automatically reverts if transfer fails
         */

        /* another way:
         *bool sendSuccess = payable(msg.sender).send(address(this).balance);
         *require(sendSuccess,"transfer fails");
         */

        /* another way
         */
        (
            bool success, /* bytes memory dataReturned*/

        ) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "transfer fails");
    }
}
