// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PureAndViewFunctions {
    uint256 public x = 10;

    // View function: Reads the state variable 'x' but does not modify it
    function getX() public view returns (uint256) {
        return x;
    }

    // Pure function: Does not read or modify any state variables
    function add(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }
}
