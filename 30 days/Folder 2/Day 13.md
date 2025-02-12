### **Day 13: Error Handling and Debugging in Solidity**

Today, you’ll learn about **error handling** in Solidity, including custom error types, `require()`, `revert()`, and `assert()`. You’ll also practice debugging smart contracts using the **Remix debugger**.

---

#### **1. Error Handling in Solidity**
Solidity provides several ways to handle errors and ensure the correctness of your smart contracts:

- **`require()`**:
  - Used to validate inputs and conditions.
  - Reverts the transaction if the condition is false and refunds remaining gas.
  - Example:
    ```solidity
    function setNumber(uint _number) public pure {
        require(_number > 0, "Number must be greater than 0");
    }
    ```

- **`revert()`**:
  - Used to explicitly revert a transaction with a custom error message.
  - Example:
    ```solidity
    function withdraw(uint _amount) public pure {
        if (_amount > 100) {
            revert("Amount too large");
        }
    }
    ```

- **`assert()`**:
  - Used to check for internal errors or invariants.
  - Reverts the transaction if the condition is false and consumes all gas.
  - Example:
    ```solidity
    function divide(uint _a, uint _b) public pure returns (uint) {
        assert(_b != 0); // Ensure denominator is not zero
        return _a / _b;
    }
    ```

- **Custom Errors**:
  - Introduced in Solidity 0.8.4, custom errors are more gas-efficient than `require` and `revert`.
  - Example:
    ```solidity
    error InsufficientBalance(uint available, uint required);

    function withdraw(uint _amount) public view {
        uint balance = address(this).balance;
        if (balance < _amount) {
            revert InsufficientBalance(balance, _amount);
        }
    }
    ```

---

#### **2. Debugging Smart Contracts**
The **Remix debugger** is a powerful tool for stepping through your smart contract code and identifying issues.

- **Steps to Debug**:
  1. Deploy the contract in Remix.
  2. Perform a transaction that triggers an error.
  3. Click the "Debug" button in the transaction log.
  4. Use the debugger to step through the code, inspect variables, and identify the issue.

---

#### **3. Practice: Write a Contract with Errors and Debug Them**
Let’s build a contract that intentionally has errors and debug them using the Remix debugger.

---

##### **Contract: ErrorProne**
This contract contains intentional errors for debugging practice.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ErrorProne {
    uint public balance;

    // Custom error
    error InsufficientBalance(uint available, uint required);

    // Function to deposit Ether
    function deposit() public payable {
        balance += msg.value;
    }

    // Function to withdraw Ether (intentional error)
    function withdraw(uint _amount) public {
        if (_amount > balance) {
            revert InsufficientBalance(balance, _amount); // Custom error
        }
        balance -= _amount;
        payable(msg.sender).transfer(_amount);
    }

    // Function to divide two numbers (intentional error)
    function divide(uint _a, uint _b) public pure returns (uint) {
        require(_b != 0, "Denominator cannot be zero"); // Require check
        return _a / _b;
    }

    // Function to check an invariant (intentional error)
    function checkInvariant(uint _value) public pure {
        assert(_value > 100); // Assert check
    }
}
```

---

##### **What to Do**:
1. **Deploy the Contract**:
   - Deploy the `ErrorProne` contract in Remix.

2. **Trigger Errors**:
   - **Withdraw Error**:
     - Deposit some Ether using the `deposit` function.
     - Try to withdraw more Ether than the balance using the `withdraw` function.
     - Observe the custom error `InsufficientBalance` in the transaction log.
   - **Divide Error**:
     - Call the `divide` function with `_b = 0`.
     - Observe the `require` error message in the transaction log.
   - **Invariant Error**:
     - Call the `checkInvariant` function with `_value = 50`.
     - Observe the `assert` error in the transaction log.

3. **Debug the Errors**:
   - Click the "Debug" button in the transaction log for each error.
   - Use the debugger to step through the code and inspect variables.

---

##### **Key Features**:
- **Custom Errors**: Used in the `withdraw` function for gas-efficient error handling.
- **`require`**: Used in the `divide` function to validate inputs.
- **`assert`**: Used in the `checkInvariant` function to check for internal errors.
- **Remix Debugger**: Used to step through the code and identify issues.

---

#### **4. Best Practices for Error Handling**
- Use **`require`** for input validation and user-facing errors.
- Use **`assert`** for internal invariants and conditions that should never fail.
- Use **custom errors** for gas-efficient error handling.
- Test your contracts thoroughly to catch errors before deployment.

---

#### **Summary of Day 13**
- Learned about error handling in Solidity: `require`, `revert`, `assert`, and custom errors.
- Practiced debugging smart contracts using the Remix debugger.
- Built an `ErrorProne` contract with intentional errors and debugged them.

By the end of Day 13, you should be comfortable handling errors and debugging smart contracts. Tomorrow, we’ll dive into more advanced topics like contract interactions and libraries!
