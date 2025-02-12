### **Day 5: Function Modifiers and Types in Solidity**

Today, you’ll learn about function modifiers (`view`, `pure`, `payable`) and understand the difference between `view` and `pure` functions. You’ll also practice creating a contract with different types of functions.

---

#### **1. Function Modifiers**
Function modifiers in Solidity define the behavior of functions. The most common ones are:

- **`view`**:
  - Indicates that the function does not modify the state of the contract.
  - It can read state variables but cannot write to them.
  - Example:
    ```solidity
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
    ```

- **`pure`**:
  - Indicates that the function does not read or modify the state of the contract.
  - It can only use its input parameters and local variables.
  - Example:
    ```solidity
    function add(uint _a, uint _b) public pure returns (uint) {
        return _a + _b;
    }
    ```

- **`payable`**:
  - Allows the function to receive Ether (ETH) along with the transaction.
  - Example:
    ```solidity
    function deposit() public payable {
        // Ether sent with the transaction is added to the contract's balance
    }
    ```

---

#### **2. Understand `view` and `pure` Functions**
- **`view` Functions**:
  - Can read state variables but cannot modify them.
  - Example:
    ```solidity
    uint public myNumber = 10;

    function getNumber() public view returns (uint) {
        return myNumber; // Reads state variable
    }
    ```

- **`pure` Functions**:
  - Cannot read or modify state variables.
  - Example:
    ```solidity
    function multiply(uint _a, uint _b) public pure returns (uint) {
        return _a * _b; // Only uses input parameters
    }
    ```

---

#### **3. Practice: Create a Contract with Different Types of Functions**
Let’s build a contract that demonstrates the use of `view`, `pure`, and `payable` functions.

---

##### **Contract: Bank**
This contract simulates a simple bank where users can deposit and withdraw Ether, and check their balance.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {
    mapping(address => uint) public balances;

    // Deposit Ether into the bank (payable function)
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += msg.value;
    }

    // Withdraw Ether from the bank
    function withdraw(uint _amount) public {
        require(_amount > 0, "Withdrawal amount must be greater than 0");
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
    }

    // Check the balance of the caller (view function)
    function getBalance() public view returns (uint) {
        return balances[msg.sender];
    }

    // Calculate the total balance of the contract (view function)
    function getTotalBalance() public view returns (uint) {
        return address(this).balance;
    }

    // Add two numbers (pure function)
    function addNumbers(uint _a, uint _b) public pure returns (uint) {
        return _a + _b;
    }
}
```

**What to Do**:
1. Deploy the contract in Remix.
2. Use `deposit` to send Ether to the contract (use the "Value" field in Remix to send Ether).
3. Use `getBalance` to check your balance.
4. Use `withdraw` to withdraw Ether from the contract.
5. Use `getTotalBalance` to check the total Ether held by the contract.
6. Use `addNumbers` to test the `pure` function.

---

##### **Contract: Math Operations**
This contract demonstrates `pure` and `view` functions for performing math operations.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MathOperations {
    uint public result;

    // Add two numbers (pure function)
    function add(uint _a, uint _b) public pure returns (uint) {
        return _a + _b;
    }

    // Multiply two numbers (pure function)
    function multiply(uint _a, uint _b) public pure returns (uint) {
        return _a * _b;
    }

    // Store the result of an addition (modifies state)
    function storeAddition(uint _a, uint _b) public {
        result = _a + _b;
    }

    // Get the stored result (view function)
    function getResult() public view returns (uint) {
        return result;
    }
}
```

**What to Do**:
1. Deploy the contract in Remix.
2. Use `add` and `multiply` to perform calculations (these are `pure` functions).
3. Use `storeAddition` to store the result of an addition in the `result` state variable.
4. Use `getResult` to retrieve the stored result (this is a `view` function).

---

#### **Summary of Day 5**
- Learned about function modifiers: `view`, `pure`, and `payable`.
- Understood the difference between `view` and `pure` functions.
- Built two contracts:
  - `Bank`: Demonstrates `payable`, `view`, and state-modifying functions.
  - `MathOperations`: Demonstrates `pure` and `view` functions for math operations.

By the end of Day 5, you should be comfortable using `view`, `pure`, and `payable` functions in Solidity. Tomorrow, we’ll explore more advanced topics like inheritance, events, and error handling!
