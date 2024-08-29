// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultiFunctionContract {
    uint public value;

    // Function to set the value
    function setValue(uint _value) public {
        value = _value;
    }

    // Function to get the value
    function getValue() public view returns (uint) {
        return value;
    }

    // Function to increment the value by 1
    function incrementValue() public {
        value++;
    }

    // Function to decrement the value by 1
    function decrementValue() public {
        require(value > 0, "Value cannot be negative");
        value--;
    }

    // Function to transfer Ether to an address
    function sendEther(address recipient, uint amount) public payable {
        require(msg.value >= amount, "Insufficient Ether");
        payable(recipient).transfer(amount);
    }

    // Function to receive Ether
    function receiveEther() public payable {}

    // Function to withdraw Ether from the contract
    function withdrawEther() public {
        require(address(this).balance > 0, "No Ether to withdraw");
        payable(msg.sender).transfer(address(this).balance);
    }
}
