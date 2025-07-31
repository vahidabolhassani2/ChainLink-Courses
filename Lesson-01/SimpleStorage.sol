// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract SimpleStorage {
    uint256 public favoriteNumber; // state variable
    address public favoriteAddress;
    string public favoriteString;
    bool public favoriteBool;

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
        favoriteNumber += 1;
    }
}
