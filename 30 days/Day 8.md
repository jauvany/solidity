### **Day 8: Modifiers and Access Control in Solidity**

Today, you’ll learn about **modifiers** and how to use them for **access control** in smart contracts. You’ll also practice building a contract with **role-based access control** to restrict certain functions to specific users.

---

#### **1. Modifiers**
Modifiers are reusable pieces of code that can be applied to functions to enforce certain conditions. They are commonly used for access control, input validation, and state checks.

- **Syntax**:
  ```solidity
  modifier onlyOwner() {
      require(msg.sender == owner, "Only the owner can call this function");
      _; // This represents the function body
  }
  ```

- **Usage**:
  ```solidity
  function restrictedFunction() public onlyOwner {
      // Function logic
  }
  ```

---

#### **2. Access Control**
Access control ensures that only authorized users can perform specific actions in a smart contract. Common patterns include:
- **Ownership**: Restrict access to the contract owner.
- **Role-Based Access Control (RBAC)**: Assign roles (e.g., admin, user) and restrict access based on roles.

---

#### **3. Practice: Develop a Smart Contract with Role-Based Access Control**
Let’s build a contract that implements **role-based access control** using modifiers.

---

##### **Contract: RoleBasedAccess**
This contract demonstrates role-based access control with three roles:
1. **Admin**: Can add or remove users and assign roles.
2. **Editor**: Can update contract data.
3. **Viewer**: Can only view contract data.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RoleBasedAccess {
    // Roles
    address public admin;
    mapping(address => bool) public editors;
    mapping(address => bool) public viewers;

    // Data
    string public data;

    // Events
    event RoleGranted(address indexed user, string role);
    event RoleRevoked(address indexed user, string role);
    event DataUpdated(address indexed user, string newData);

    // Modifiers
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    modifier onlyEditor() {
        require(editors[msg.sender], "Only editors can perform this action");
        _;
    }

    modifier onlyViewer() {
        require(viewers[msg.sender], "Only viewers can perform this action");
        _;
    }

    // Constructor
    constructor() {
        admin = msg.sender; // Deployer is the admin
    }

    // Grant a role to a user
    function grantRole(address _user, string memory _role) public onlyAdmin {
        if (keccak256(bytes(_role)) == keccak256(bytes("editor"))) {
            editors[_user] = true;
        } else if (keccak256(bytes(_role)) == keccak256(bytes("viewer"))) {
            viewers[_user] = true;
        } else {
            revert("Invalid role");
        }
        emit RoleGranted(_user, _role);
    }

    // Revoke a role from a user
    function revokeRole(address _user, string memory _role) public onlyAdmin {
        if (keccak256(bytes(_role)) == keccak256(bytes("editor"))) {
            editors[_user] = false;
        } else if (keccak256(bytes(_role)) == keccak256(bytes("viewer"))) {
            viewers[_user] = false;
        } else {
            revert("Invalid role");
        }
        emit RoleRevoked(_user, _role);
    }

    // Update data (only editors)
    function updateData(string memory _newData) public onlyEditor {
        data = _newData;
        emit DataUpdated(msg.sender, _newData);
    }

    // View data (only viewers)
    function viewData() public view onlyViewer returns (string memory) {
        return data;
    }
}
```

---

##### **What to Do**:
1. **Deploy the Contract**:
   - Deploy the contract in Remix. The deployer becomes the `admin`.

2. **Grant Roles**:
   - Use `grantRole` to assign roles to addresses.
     - Example: Grant the `editor` role to an address.
     ```solidity
     grantRole(0x123..., "editor");
     ```
     - Example: Grant the `viewer` role to an address.
     ```solidity
     grantRole(0x456..., "viewer");
     ```

3. **Update Data**:
   - Use `updateData` to update the contract data (only `editors` can do this).
     ```solidity
     updateData("New Data");
     ```

4. **View Data**:
   - Use `viewData` to view the contract data (only `viewers` can do this).

5. **Revoke Roles**:
   - Use `revokeRole` to remove roles from addresses.
     ```solidity
     revokeRole(0x123..., "editor");
     ```

---

##### **Key Features**:
- **Admin**: Can grant and revoke roles.
- **Editors**: Can update the contract data.
- **Viewers**: Can only view the contract data.
- **Events**: Log role assignments and data updates.

---

#### **4. Best Practices for Access Control**
- Use **modifiers** to enforce access control.
- Avoid hardcoding addresses in the contract.
- Use **events** to log role changes and important actions.
- Consider using libraries like **OpenZeppelin** for standardized access control.

---

#### **Summary of Day 8**
- Learned about **modifiers** and how to use them for access control.
- Built a **role-based access control** contract with three roles: admin, editor, and viewer.
- Practiced granting, revoking, and enforcing roles using modifiers.
- Explored best practices for implementing access control in smart contracts.

By the end of Day 8, you should be comfortable using modifiers and implementing role-based access control in your contracts. Tomorrow, we’ll dive into more advanced topics like inheritance and error handling!
