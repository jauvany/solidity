Day 7-10: Contract Lifecycle and Storage vs Memory

### **Day 7: Contract Lifecycle and Storage vs Memory in Solidity**

Today, you’ll learn about the **contract lifecycle** (deployment, creation, execution, and destruction) and the difference between **storage** and **memory** in Solidity. You’ll also practice writing a contract that uses both storage and memory to compare their efficiency.

---

#### **1. Contract Lifecycle**
The lifecycle of a smart contract consists of the following stages:

1. **Deployment**:
   - The contract is compiled into bytecode and deployed to the Ethereum blockchain.
   - The constructor is executed once during deployment.
   - Example:
     ```solidity
     contract MyContract {
         constructor() {
             // Initialization code
         }
     }
     ```

2. **Creation**:
   - The contract is instantiated on the blockchain, and its address is generated.
   - State variables are initialized.

3. **Execution**:
   - Users interact with the contract by calling its functions.
   - State changes are recorded on the blockchain.

4. **Destruction**:
   - A contract can be self-destructed using the `selfdestruct` function.
   - Example:
     ```solidity
     function destroy() public {
         selfdestruct(payable(msg.sender));
     }
     ```
   - **Note**: `selfdestruct` is being deprecated in future Ethereum upgrades, so use it cautiously.

---

#### **2. Storage vs Memory**
Solidity has two main data location types: **storage** and **memory**.

- **Storage**:
  - Persistent data stored on the blockchain.
  - State variables are stored in storage.
  - Expensive to read and write (high gas costs).
  - Example:
    ```solidity
    uint public myNumber; // Stored in storage
    ```

- **Memory**:
  - Temporary data used during function execution.
  - Function arguments and local variables are stored in memory.
  - Cheaper to read and write (low gas costs).
  - Example:
    ```solidity
    function add(uint _a, uint _b) public pure returns (uint) {
        uint result = _a + _b; // Stored in memory
        return result;
    }
    ```

- **Key Differences**:
  | **Aspect**       | **Storage**                     | **Memory**                     |
  |-------------------|---------------------------------|--------------------------------|
  | **Persistence**   | Persistent (stored on-chain)    | Temporary (cleared after execution) |
  | **Gas Cost**      | High                           | Low                            |
  | **Usage**         | State variables                | Local variables, function arguments |

---

#### **3. Practice: Write a Contract That Uses Both Storage and Memory**
Let’s build a contract that demonstrates the use of **storage** and **memory** and compares their efficiency.

---

##### **Contract: StorageVsMemory**
This contract compares the gas costs of using storage and memory for the same operation.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StorageVsMemory {
    uint[] public storageArray; // Stored in storage
    uint public storageSum;     // Stored in storage

    // Function to calculate sum using storage
    function calculateSumUsingStorage() public {
        uint sum = 0;
        for (uint i = 0; i < storageArray.length; i++) {
            sum += storageArray[i]; // Reading from storage
        }
        storageSum = sum; // Writing to storage
    }

    // Function to calculate sum using memory
    function calculateSumUsingMemory() public {
        uint[] memory memoryArray = storageArray; // Copy storage to memory
        uint sum = 0;
        for (uint i = 0; i < memoryArray.length; i++) {
            sum += memoryArray[i]; // Reading from memory
        }
        storageSum = sum; // Writing to storage
    }

    // Function to add numbers to the array
    function addNumbers(uint[] memory _numbers) public {
        for (uint i = 0; i < _numbers.length; i++) {
            storageArray.push(_numbers[i]); // Writing to storage
        }
    }

    // Function to reset the array
    function resetArray() public {
        delete storageArray;
    }
}
```

**What to Do**:
1. Deploy the contract in Remix.
2. Use `addNumbers` to add an array of numbers (e.g., `[10, 20, 30, 40, 50]`).
3. Call `calculateSumUsingStorage` and observe the gas cost.
4. Call `calculateSumUsingMemory` and observe the gas cost.
5. Compare the gas costs of the two functions.

---

##### **Gas Cost Comparison**
- **`calculateSumUsingStorage`**:
  - Reads and writes directly to storage, which is expensive.
  - Higher gas cost.
- **`calculateSumUsingMemory`**:
  - Copies data from storage to memory, performs calculations in memory, and writes the result to storage.
  - Lower gas cost for calculations.

---

#### **4. Best Practices for Storage and Memory**
- Use **memory** for temporary data and calculations to save gas.
- Use **storage** for persistent data that needs to be stored on-chain.
- Minimize the number of storage reads and writes to optimize gas usage.

---

#### **Summary of Day 7**
- Learned about the **contract lifecycle**: deployment, creation, execution, and destruction.
- Understood the difference between **storage** and **memory** in Solidity.
- Built a contract (`StorageVsMemory`) to compare the gas costs of using storage and memory.
- Explored best practices for optimizing gas usage.

By the end of Day 7, you should be comfortable managing data in storage and memory and optimizing your contracts for gas efficiency. Tomorrow, we’ll dive into more advanced topics like inheritance and error handling!
