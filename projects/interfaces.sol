pragma solidity ^0.8.0;

interface Ivehicle {
    function start() external returns(string memory);
}

contract car is Ivehicle{
    function start() pure external returns(string memory){
    return "car is starting";}
    
}