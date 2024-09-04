// SPDX-Licence-Identifier: UNLICENSED
pragma solidity 0.8.0;

contract Me {
    string public greet = "Hello World!";

    function checkSalut() public pure returns (string memory) {
        return "We just greeted!";

    }
}
