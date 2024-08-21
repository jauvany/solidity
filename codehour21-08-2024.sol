pragma solidity ^0.8.0;

contract Practice {

    uint year = 2024;

    function setYear() public returns(uint) {
        return year;
    }

    function getYear() public view returns(uint) {
        return year;
    }
}