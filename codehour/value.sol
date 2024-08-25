pragma solidity ^0.8.0;

contract value {

    function returnResult() public pure returns (uint) {
        uint a = 1;
        uint b = 2;
        uint c = a + b;
        return c; 
    }
}