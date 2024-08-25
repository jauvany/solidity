pragma solidity ^0.8.8;

contract Animal {
    function sound() public pure virtual returns(string memory){
        return "Animal sound";
    }
    
}

contract Dog is Animal {
    function sound() public pure override returns(string memory){
        return "Bark";
    }
}

contract Cat is Animal { 
    function sound() public pure override  returns(string memory){
        return "Meow";
    }

}
