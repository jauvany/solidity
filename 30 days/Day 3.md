### **Day 3: Deep Dive into Solidity Data Types and Functions**

Today, you’ll explore Solidity data types in detail, learn about function visibility, and practice writing basic contracts using these concepts.

---

#### **1. Solidity Data Types**
Solidity provides several data types to handle different kinds of data. Here’s a breakdown of the most commonly used ones:

- **uint**: Unsigned integer (positive numbers only).
  - Example: `uint256 public myNumber = 100;` (256-bit unsigned integer).
- **int**: Signed integer (positive and negative numbers).
  - Example: `int public mySignedNumber = -50;`.
- **address**: Stores an Ethereum address (20 bytes).
  - Example: `address public myAddress = 0x123...;`.
- **bool**: Boolean (`true` or `false`).
  - Example: `bool public isActive = true;`.
- **string**: Text data.
  - Example: `string public myString = "Hello, Solidity!";`.
- **bytes**: Fixed or dynamic byte arrays.
  - Example: `bytes32 public myBytes = "abc";` (fixed-size).
  - Example: `bytes public dynamicBytes;` (dynamic-size).
- **Arrays**:
  - Fixed-size: `uint[5] public fixedArray;`.
  - Dynamic-size: `uint[] public dynamicArray;`.
- **Structs**: Custom data structures to group related data.
  - Example:
    ```solidity
    struct Person {
        string name;
        uint age;
    }
    Person public myPerson = Person("Alice", 25);
    ```
- **Mappings**: Key-value storage.
  - Example: `mapping(address => uint) public balances;`.

---

#### **2. Functions: Visibility**
Functions in Solidity have visibility specifiers that control who can call them:

- **`public`**: Can be called from anywhere (inside or outside the contract).
  - Example:
    ```solidity
    function myPublicFunction() public {
        // Code
    }
    ```
- **`private`**: Can only be called from within the contract.
  - Example:
    ```solidity
    function myPrivateFunction() private {
        // Code
    }
    ```
- **`internal`**: Can be called from within the contract and derived contracts.
  - Example:
    ```solidity
    function myInternalFunction() internal {
        // Code
    }
    ```
- **`external`**: Can only be called from outside the contract.
  - Example:
    ```solidity
    function myExternalFunction() external {
        // Code
    }
    ```

---

#### **3. Practice: Write Basic Contracts**
Let’s practice by writing a few contracts that use various data types and functions.

---

##### **Contract 1: Simple Storage**
This contract stores and retrieves a number.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    uint public storedNumber;

    function setNumber(uint _number) public {
        storedNumber = _number;
    }

    function getNumber() public view returns (uint) {
        return storedNumber;
    }
}
```

**What to Do**:
1. Deploy the contract in Remix.
2. Use `setNumber` to store a number.
3. Use `getNumber` to retrieve the stored number.

---

##### **Contract 2: Address Book**
This contract stores and retrieves addresses.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AddressBook {
    mapping(string => address) public addresses;

    function addAddress(string memory _name, address _address) public {
        addresses[_name] = _address;
    }

    function getAddress(string memory _name) public view returns (address) {
        return addresses[_name];
    }
}
```

**What to Do**:
1. Deploy the contract in Remix.
2. Use `addAddress` to store an address with a name (e.g., `"Alice"`).
3. Use `getAddress` to retrieve the address by name.

---

##### **Contract 3: User Profile**
This contract uses a `struct` to store user profiles.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserProfile {
    struct Profile {
        string name;
        uint age;
        address wallet;
    }

    mapping(address => Profile) public profiles;

    function createProfile(string memory _name, uint _age) public {
        profiles[msg.sender] = Profile(_name, _age, msg.sender);
    }

    function getProfile(address _user) public view returns (string memory, uint, address) {
        Profile memory profile = profiles[_user];
        return (profile.name, profile.age, profile.wallet);
    }
}
```

**What to Do**:
1. Deploy the contract in Remix.
2. Use `createProfile` to create a profile for yourself.
3. Use `getProfile` to retrieve your profile.

---

##### **Contract 4: Visibility Example**
This contract demonstrates function visibility.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VisibilityExample {
    uint private privateData;
    uint internal internalData;
    uint public publicData;

    function setPrivateData(uint _data) private {
        privateData = _data;
    }

    function setInternalData(uint _data) internal {
        internalData = _data;
    }

    function setPublicData(uint _data) public {
        publicData = _data;
    }

    function getPrivateData() public view returns (uint) {
        return privateData;
    }

    function getInternalData() public view returns (uint) {
        return internalData;
    }
}
```

**What to Do**:
1. Deploy the contract in Remix.
2. Try calling `setPrivateData` and observe the error (it’s private!).
3. Call `setPublicData` and `getPrivateData` to see how visibility works.

---

#### **Summary of Day 3**
- Explored Solidity data types: `uint`, `int`, `address`, `bool`, `string`, `bytes`, `struct`, and `mapping`.
- Learned about function visibility: `public`, `private`, `internal`, and `external`.
- Practiced writing basic contracts:
  - `SimpleStorage`: Store and retrieve a number.
  - `AddressBook`: Store and retrieve addresses.
  - `UserProfile`: Use `struct` to store user profiles.
  - `VisibilityExample`: Understand function visibility.

By the end of Day 3, you should feel confident working with Solidity data types and functions. Tomorrow, we’ll dive into more advanced topics like inheritance, events, and error handling!
