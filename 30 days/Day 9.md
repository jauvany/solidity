### **Day 9: Structs and Arrays in Solidity**

Today, you’ll learn about **structs** and **arrays**, which are essential for working with custom data types and collections in Solidity. You’ll also practice building a contract that uses structs to manage user data.

---

#### **1. Structs**
Structs allow you to define custom data types that group related data together. They are useful for representing complex data structures.

- **Syntax**:
  ```solidity
  struct User {
      string name;
      uint age;
      address wallet;
  }
  ```

- **Usage**:
  ```solidity
  User public myUser = User("Alice", 25, 0x123...);
  ```

---

#### **2. Arrays**
Arrays are used to store collections of data. Solidity supports both **fixed-size** and **dynamic-size** arrays.

- **Fixed-Size Arrays**:
  ```solidity
  uint[5] public fixedArray; // Array with 5 elements
  ```

- **Dynamic-Size Arrays**:
  ```solidity
  uint[] public dynamicArray; // Array with no fixed size
  ```

- **Array Operations**:
  - Add elements: `dynamicArray.push(10);`
  - Get length: `dynamicArray.length;`
  - Access elements: `dynamicArray[0];`

---

#### **3. Practice: Create a Contract Using Structs to Manage User Data**
Let’s build a contract that uses structs and arrays to manage user data.

---

##### **Contract: UserManager**
This contract allows you to add, update, and retrieve user data using structs and arrays.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserManager {
    // Define a struct for User
    struct User {
        string name;
        uint age;
        address wallet;
    }

    // Array to store users
    User[] public users;

    // Mapping to track user existence
    mapping(address => bool) public userExists;

    // Event to log user creation
    event UserCreated(address indexed wallet, string name, uint age);

    // Event to log user update
    event UserUpdated(address indexed wallet, string name, uint age);

    // Add a new user
    function addUser(string memory _name, uint _age) public {
        require(!userExists[msg.sender], "User already exists");
        
        User memory newUser = User({
            name: _name,
            age: _age,
            wallet: msg.sender
        });

        users.push(newUser);
        userExists[msg.sender] = true;

        emit UserCreated(msg.sender, _name, _age);
    }

    // Update user data
    function updateUser(string memory _name, uint _age) public {
        require(userExists[msg.sender], "User does not exist");

        for (uint i = 0; i < users.length; i++) {
            if (users[i].wallet == msg.sender) {
                users[i].name = _name;
                users[i].age = _age;
                emit UserUpdated(msg.sender, _name, _age);
                break;
            }
        }
    }

    // Get user data by wallet address
    function getUser(address _wallet) public view returns (string memory, uint, address) {
        require(userExists[_wallet], "User does not exist");

        for (uint i = 0; i < users.length; i++) {
            if (users[i].wallet == _wallet) {
                return (users[i].name, users[i].age, users[i].wallet);
            }
        }
        revert("User not found");
    }

    // Get total number of users
    function getTotalUsers() public view returns (uint) {
        return users.length;
    }
}
```

---

##### **What to Do**:
1. **Deploy the Contract**:
   - Deploy the contract in Remix.

2. **Add a User**:
   - Use `addUser` to create a new user.
     ```solidity
     addUser("Alice", 25);
     ```

3. **Update User Data**:
   - Use `updateUser` to update the user’s name and age.
     ```solidity
     updateUser("Alice Smith", 26);
     ```

4. **Get User Data**:
   - Use `getUser` to retrieve user data by wallet address.
     ```solidity
     getUser(0x123...);
     ```

5. **Get Total Users**:
   - Use `getTotalUsers` to check the total number of users.
     ```solidity
     getTotalUsers();
     ```

---

##### **Key Features**:
- **Structs**: Used to define a custom `User` data type.
- **Arrays**: Used to store a collection of users.
- **Mapping**: Used to track whether a user exists.
- **Events**: Log user creation and updates.

---

#### **4. Best Practices for Structs and Arrays**
- Use **structs** to group related data and improve code readability.
- Use **mappings** for efficient lookups (e.g., checking if a user exists).
- Use **events** to log important actions for off-chain systems.
- Be mindful of gas costs when working with large arrays.

---

#### **Summary of Day 9**
- Learned about **structs** and how to define custom data types.
- Explored **arrays** for storing collections of data.
- Built a `UserManager` contract to manage user data using structs and arrays.
- Practiced adding, updating, and retrieving user data.

By the end of Day 9, you should be comfortable working with structs and arrays in Solidity. Tomorrow, we’ll dive into more advanced topics like inheritance and error handling!
