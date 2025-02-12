### **Day 6: Event Logging in Solidity**

Today, you’ll learn about **events** in Solidity, how to emit them, and why they are useful for logging smart contract transactions and state changes. You’ll also practice building a contract that emits events when its state changes.

---

#### **1. Event Logging and Emitting Events**
Events are a way for smart contracts to communicate with external applications (e.g., frontends) about specific occurrences in the contract. They are stored in the Ethereum blockchain’s transaction logs and can be listened to by external systems.

- **Why Use Events?**
  - Notify external applications about important state changes.
  - Provide a gas-efficient way to store data (logs are cheaper than storage).
  - Enable off-chain systems to react to on-chain events.

- **How to Define and Emit Events**:
  - Use the `event` keyword to define an event.
  - Use the `emit` keyword to trigger the event.
  - Example:
    ```solidity
    event ValueChanged(address indexed user, uint oldValue, uint newValue);

    function setValue(uint _newValue) public {
        uint oldValue = value;
        value = _newValue;
        emit ValueChanged(msg.sender, oldValue, _newValue);
    }
    ```

- **Indexed Parameters**:
  - Use the `indexed` keyword to make event parameters searchable.
  - Example:
    ```solidity
    event Transfer(address indexed from, address indexed to, uint amount);
    ```

---

#### **2. Understand Logging for Smart Contract Transactions**
When an event is emitted:
- It is recorded in the transaction logs.
- Logs are stored on the blockchain but are not accessible by smart contracts.
- External applications (e.g., frontends) can listen to these logs using libraries like **Web3.js** or **Ethers.js**.

---

#### **3. Practice: Build a Contract That Emits Events**
Let’s build a contract that emits events when its state changes.

---

##### **Contract: StateLogger**
This contract logs state changes using events.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StateLogger {
    uint public value;
    address public owner;

    // Event to log value changes
    event ValueChanged(address indexed user, uint oldValue, uint newValue);

    // Event to log ownership transfers
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor(uint _initialValue) {
        value = _initialValue;
        owner = msg.sender;
    }

    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    // Function to update the value
    function setValue(uint _newValue) public onlyOwner {
        uint oldValue = value;
        value = _newValue;
        emit ValueChanged(msg.sender, oldValue, _newValue);
    }

    // Function to transfer ownership
    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "Invalid address");
        emit OwnershipTransferred(owner, _newOwner);
        owner = _newOwner;
    }
}
```

**What to Do**:
1. Deploy the contract in Remix with an initial value (e.g., `100`).
2. Call `setValue` to update the value and observe the `ValueChanged` event in the logs.
3. Call `transferOwnership` to transfer ownership and observe the `OwnershipTransferred` event in the logs.

---

##### **Contract: TokenTransfer**
This contract simulates a token transfer system and emits events for transfers.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenTransfer {
    mapping(address => uint) public balances;

    // Event to log token transfers
    event Transfer(address indexed from, address indexed to, uint amount);

    // Initialize balances for testing
    constructor() {
        balances[msg.sender] = 1000; // Give the deployer some tokens
    }

    // Function to transfer tokens
    function transfer(address _to, uint _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
    }

    // Function to check balance
    function getBalance(address _user) public view returns (uint) {
        return balances[_user];
    }
}
```

**What to Do**:
1. Deploy the contract in Remix.
2. Use `transfer` to send tokens to another address and observe the `Transfer` event in the logs.
3. Use `getBalance` to check the balances of the sender and receiver.

---

#### **4. Listening to Events in a Frontend**
To listen to events in a frontend application, you can use **Web3.js** or **Ethers.js**. Here’s an example using **Ethers.js**:

```javascript
const provider = new ethers.providers.Web3Provider(window.ethereum);
const contractAddress = "YOUR_CONTRACT_ADDRESS";
const abi = [ /* ABI of the contract */ ];
const contract = new ethers.Contract(contractAddress, abi, provider);

// Listen to the Transfer event
contract.on("Transfer", (from, to, amount, event) => {
    console.log(`Transfer: ${amount} tokens from ${from} to ${to}`);
});
```

---

#### **Summary of Day 6**
- Learned about **events** and how to emit them in Solidity.
- Understood the importance of event logging for smart contract transactions and state changes.
- Built two contracts:
  - `StateLogger`: Emits events for value changes and ownership transfers.
  - `TokenTransfer`: Emits events for token transfers.
- Explored how to listen to events in a frontend application.

By the end of Day 6, you should be comfortable using events to log and communicate state changes in your smart contracts. Tomorrow, we’ll dive into more advanced topics like inheritance and error handling!
