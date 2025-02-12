### **Day 10: Mappings in Solidity**

Today, you’ll learn about **mappings**, a powerful data structure in Solidity that allows for efficient key-value storage. You’ll also practice building a contract that uses mappings for efficient data retrieval.

---

#### **1. Mappings**
Mappings are a key-value data structure in Solidity, similar to dictionaries or hash maps in other programming languages. They are highly efficient for lookups and storage.

- **Syntax**:
  ```solidity
  mapping(keyType => valueType) public myMapping;
  ```
  - Example:
    ```solidity
    mapping(address => uint) public balances;
    ```

- **Key Features**:
  - Keys are not stored in the mapping, so you cannot iterate over them.
  - Values are initialized to their default value (e.g., `0` for `uint`, `false` for `bool`).
  - Efficient for lookups and storage.

---

#### **2. Practice: Build a Contract Using Mappings**
Let’s build a contract that uses mappings to store and retrieve user balances efficiently.

---

##### **Contract: BalanceManager**
This contract allows users to deposit and withdraw Ether and uses mappings to track balances.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BalanceManager {
    // Mapping to store user balances
    mapping(address => uint) public balances;

    // Event to log deposits
    event Deposit(address indexed user, uint amount);

    // Event to log withdrawals
    event Withdrawal(address indexed user, uint amount);

    // Deposit Ether into the contract
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Withdraw Ether from the contract
    function withdraw(uint _amount) public {
        require(_amount > 0, "Withdrawal amount must be greater than 0");
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        emit Withdrawal(msg.sender, _amount);
    }

    // Get the balance of a user
    function getBalance(address _user) public view returns (uint) {
        return balances[_user];
    }
}
```

---

##### **What to Do**:
1. **Deploy the Contract**:
   - Deploy the contract in Remix.

2. **Deposit Ether**:
   - Use the `deposit` function to send Ether to the contract.
     - In Remix, set the "Value" field to a specific amount (e.g., 1 ETH) and click `deposit`.

3. **Check Balance**:
   - Use `getBalance` to check the balance of your address.
     ```solidity
     getBalance(0x123...);
     ```

4. **Withdraw Ether**:
   - Use `withdraw` to withdraw Ether from the contract.
     ```solidity
     withdraw(0.5 ether);
     ```

5. **Observe Events**:
   - Check the logs in Remix to see the `Deposit` and `Withdrawal` events.

---

##### **Key Features**:
- **Mappings**: Used to store and retrieve user balances efficiently.
- **Events**: Log deposits and withdrawals for transparency.
- **Payable Functions**: Allow the contract to receive Ether.

---

#### **3. Advanced Example: User Profiles with Mappings**
Let’s build a more advanced contract that uses mappings to store user profiles.

---

##### **Contract: UserProfileManager**
This contract uses mappings to store and retrieve user profiles.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserProfileManager {
    // Define a struct for User Profile
    struct Profile {
        string name;
        uint age;
    }

    // Mapping to store user profiles
    mapping(address => Profile) public profiles;

    // Event to log profile creation
    event ProfileCreated(address indexed user, string name, uint age);

    // Event to log profile update
    event ProfileUpdated(address indexed user, string name, uint age);

    // Create or update a user profile
    function setProfile(string memory _name, uint _age) public {
        profiles[msg.sender] = Profile(_name, _age);

        if (bytes(_name).length > 0 && _age > 0) {
            emit ProfileCreated(msg.sender, _name, _age);
        } else {
            emit ProfileUpdated(msg.sender, _name, _age);
        }
    }

    // Get a user profile
    function getProfile(address _user) public view returns (string memory, uint) {
        Profile memory profile = profiles[_user];
        return (profile.name, profile.age);
    }
}
```

---

##### **What to Do**:
1. **Deploy the Contract**:
   - Deploy the contract in Remix.

2. **Set a Profile**:
   - Use `setProfile` to create or update a user profile.
     ```solidity
     setProfile("Alice", 25);
     ```

3. **Get a Profile**:
   - Use `getProfile` to retrieve a user profile.
     ```solidity
     getProfile(0x123...);
     ```

4. **Observe Events**:
   - Check the logs in Remix to see the `ProfileCreated` and `ProfileUpdated` events.

---

##### **Key Features**:
- **Structs**: Used to define a custom `Profile` data type.
- **Mappings**: Used to store and retrieve user profiles efficiently.
- **Events**: Log profile creation and updates.

---

#### **4. Best Practices for Mappings**
- Use mappings for efficient key-value storage and lookups.
- Combine mappings with structs to store complex data.
- Use events to log important actions for off-chain systems.

---

#### **Summary of Day 10**
- Learned about **mappings** and their use cases in Solidity.
- Built two contracts:
  - `BalanceManager`: Tracks user balances using mappings.
  - `UserProfileManager`: Manages user profiles using mappings and structs.
- Practiced efficient data storage and retrieval using mappings.

By the end of Day 10, you should be comfortable using mappings to store and retrieve data efficiently in your smart contracts. Tomorrow, we’ll dive into more advanced topics like inheritance and error handling!
