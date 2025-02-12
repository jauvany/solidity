Day 4-6: Control Structures and Functions

### **Day 4: Conditionals and Loops in Solidity**

Today, you’ll learn how to use conditionals (`if`, `else`, `require`, `assert`, `revert`) and loops (`for`, `while`, `do-while`) in Solidity. These are essential for controlling the flow of your smart contracts and handling errors effectively.

---

#### **1. Conditionals**
Conditionals allow you to execute code based on certain conditions.

- **`if` and `else`**:
  - Used to execute code blocks based on a condition.
  - Example:
    ```solidity
    function checkNumber(uint _number) public pure returns (string memory) {
        if (_number > 10) {
            return "Greater than 10";
        } else if (_number == 10) {
            return "Equal to 10";
        } else {
            return "Less than 10";
        }
    }
    ```

- **`require`**:
  - Used to validate inputs and conditions. If the condition is false, it reverts the transaction and consumes remaining gas.
  - Example:
    ```solidity
    function setNumber(uint _number) public pure {
        require(_number > 0, "Number must be greater than 0");
        // Code to execute if condition is true
    }
    ```

- **`assert`**:
  - Used to check for internal errors or invariants. If the condition is false, it reverts the transaction and consumes all gas.
  - Example:
    ```solidity
    function divide(uint _a, uint _b) public pure returns (uint) {
        assert(_b != 0); // Ensure denominator is not zero
        return _a / _b;
    }
    ```

- **`revert`**:
  - Used to explicitly revert a transaction with a custom error message.
  - Example:
    ```solidity
    function withdraw(uint _amount) public pure {
        if (_amount > 100) {
            revert("Amount too large");
        }
        // Code to execute if amount is valid
    }
    ```

---

#### **2. Loops**
Loops allow you to repeat a block of code multiple times.

- **`for` Loop**:
  - Used to iterate a fixed number of times.
  - Example:
    ```solidity
    function sumNumbers(uint _n) public pure returns (uint) {
        uint sum = 0;
        for (uint i = 1; i <= _n; i++) {
            sum += i;
        }
        return sum;
    }
    ```

- **`while` Loop**:
  - Used to iterate as long as a condition is true.
  - Example:
    ```solidity
    function factorial(uint _n) public pure returns (uint) {
        uint result = 1;
        uint i = 1;
        while (i <= _n) {
            result *= i;
            i++;
        }
        return result;
    }
    ```

- **`do-while` Loop**:
  - Similar to `while`, but the condition is checked after the loop body.
  - Example:
    ```solidity
    function countDown(uint _n) public pure returns (uint) {
        uint count = _n;
        do {
            count--;
        } while (count > 0);
        return count;
    }
    ```

---

#### **3. Practice: Build a Contract with Loops and Conditionals**
Let’s build a contract that utilizes loops and conditionals to solve a problem.

---

##### **Contract: Number Analyzer**
This contract analyzes a list of numbers and provides insights like sum, average, and maximum.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NumberAnalyzer {
    uint[] public numbers;

    // Add numbers to the list
    function addNumbers(uint[] memory _numbers) public {
        for (uint i = 0; i < _numbers.length; i++) {
            numbers.push(_numbers[i]);
        }
    }

    // Calculate the sum of numbers
    function getSum() public view returns (uint) {
        uint sum = 0;
        for (uint i = 0; i < numbers.length; i++) {
            sum += numbers[i];
        }
        return sum;
    }

    // Calculate the average of numbers
    function getAverage() public view returns (uint) {
        require(numbers.length > 0, "No numbers added");
        uint sum = getSum();
        return sum / numbers.length;
    }

    // Find the maximum number
    function getMax() public view returns (uint) {
        require(numbers.length > 0, "No numbers added");
        uint max = numbers[0];
        for (uint i = 1; i < numbers.length; i++) {
            if (numbers[i] > max) {
                max = numbers[i];
            }
        }
        return max;
    }

    // Reset the list of numbers
    function resetNumbers() public {
        delete numbers;
    }
}
```

**What to Do**:
1. Deploy the contract in Remix.
2. Use `addNumbers` to add an array of numbers (e.g., `[10, 20, 30, 40, 50]`).
3. Call `getSum`, `getAverage`, and `getMax` to analyze the numbers.
4. Use `resetNumbers` to clear the list.

---

##### **Contract: Voting System**
This contract allows users to vote for candidates and counts the votes.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {
    mapping(string => uint) public votes;
    string[] public candidates;

    constructor(string[] memory _candidates) {
        candidates = _candidates;
    }

    // Vote for a candidate
    function vote(string memory _candidate) public {
        require(isValidCandidate(_candidate), "Invalid candidate");
        votes[_candidate]++;
    }

    // Check if a candidate is valid
    function isValidCandidate(string memory _candidate) private view returns (bool) {
        for (uint i = 0; i < candidates.length; i++) {
            if (keccak256(bytes(candidates[i])) == keccak256(bytes(_candidate))) {
                return true;
            }
        }
        return false;
    }

    // Get total votes for a candidate
    function getVotes(string memory _candidate) public view returns (uint) {
        require(isValidCandidate(_candidate), "Invalid candidate");
        return votes[_candidate];
    }
}
```

**What to Do**:
1. Deploy the contract with an array of candidates (e.g., `["Alice", "Bob", "Charlie"]`).
2. Use `vote` to vote for a candidate.
3. Use `getVotes` to check the vote count for a candidate.

---

#### **Summary of Day 4**
- Learned about conditionals: `if`, `else`, `require`, `assert`, and `revert`.
- Explored loops: `for`, `while`, and `do-while`.
- Built two contracts:
  - `NumberAnalyzer`: Analyzes a list of numbers using loops and conditionals.
  - `VotingSystem`: Implements a simple voting system with candidate validation.

By the end of Day 4, you should be comfortable using conditionals and loops in Solidity to control the flow of your smart contracts. Tomorrow, we’ll dive into more advanced topics like inheritance, events, and error handling!
