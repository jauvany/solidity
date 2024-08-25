pragma solidity ^0.8.0;

library Arithmeticlib {
    function Add(uint a, uint b) public pure returns(uint) {
        return a + b;
    }

    function Subtract(uint a, uint b) public pure returns(uint) {
        return a - b;
    }
    function Multiply(uint a, uint b) public pure returns(uint) {
        return a * b;
    }
    function Divide(uint a, uint b) public pure returns(uint) {
        require(b > 0, "division by zero");
        return a / b;
    }
}

contract calculator {
    using Arithmeticlib for uint;

    function calculate() public pure returns(uint) {
        uint a = 10;
        uint b = 2;
        return a.Add(b); // example of using a library
    }
}
