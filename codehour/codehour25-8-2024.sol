// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    // State variables
    uint256 private storedData;
    address private owner;

    // Constructor to set the owner to the deployer of the contract
    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict access to owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    // Function to set a value (only owner can call this)
    function set(uint256 x) public onlyOwner {
        storedData = x;
    }

    // Function to get the stored value
    function get() public view returns (uint256) {
        return storedData;
    }
}
