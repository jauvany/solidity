To create a smart contract in Solidity, we will build a simple contract that demonstrates some common features. This contract will allow users to:

1. Store a value on the blockchain.
2. Retrieve the stored value.
3. Only allow the owner of the contract to update the value.

### Pseudocode
1. **Define Contract**:
   - Define a `SimpleStorage` contract.
2. **Declare Variables**:
   - `uint256` to store the value.
   - `address` to store the owner of the contract.
3. **Constructor**:
   - Set the `owner` to the address that deploys the contract.
4. **Modifiers**:
   - A `modifier` to restrict access to the owner.
5. **Functions**:
   - A `set` function to update the value (restricted to the owner).
   - A `get` function to retrieve the current value.

### Solidity Code

```solidity
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
```

### Key Features:
- **Access Control**: Only the owner can set the value.
- **Data Storage**: The value is stored on the blockchain.
- **View Function**: Anyone can view the stored value.

This smart contract is a basic example and can be expanded with additional features such as events, more complex data structures, and interaction with other contracts.

**a.** Implement additional features like events to log when the value is set.

**b.** Add unit tests for this smart contract using the Truffle or Hardhat framework.