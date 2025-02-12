# Day 11-15: Intermediate Solidity Concepts

### **Day 11: Inheritance in Solidity**

Today, you’ll learn about **inheritance** in Solidity, which allows you to create modular and reusable code by defining parent (base) contracts and child (derived) contracts. You’ll also practice building a contract that uses inheritance for modularity.

---

#### **1. Inheritance in Solidity**
Inheritance allows a contract to inherit properties (state variables) and behaviors (functions) from another contract. This promotes code reuse and modularity.

- **Syntax**:
  ```solidity
  contract Parent {
      // Parent contract code
  }

  contract Child is Parent {
      // Child contract code
  }
  ```

- **Key Concepts**:
  - **Base Contract (Parent)**: The contract being inherited from.
  - **Derived Contract (Child)**: The contract that inherits from the base contract.
  - **Function Overriding**: A child contract can override a function from the parent contract using the `override` keyword.

---

#### **2. Solidity’s Inheritance Model**
Solidity supports multiple inheritance, meaning a contract can inherit from multiple parent contracts. The inheritance hierarchy is resolved using **C3 linearization**.

- **Example**:
  ```solidity
  contract A {
      function foo() public pure virtual returns (string memory) {
          return "A";
      }
  }

  contract B is A {
      function foo() public pure virtual override returns (string memory) {
          return "B";
      }
  }

  contract C is A {
      function foo() public pure virtual override returns (string memory) {
          return "C";
      }
  }

  contract D is B, C {
      function foo() public pure override(B, C) returns (string memory) {
          return super.foo(); // Calls C.foo() because of C3 linearization
      }
  }
  ```

---

#### **3. Practice: Build a Contract with Inheritance**
Let’s build a contract hierarchy to demonstrate inheritance and function overriding.

---

##### **Contract: Vehicle System**
This contract hierarchy represents a vehicle system with modularity and inheritance.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Base contract: Vehicle
contract Vehicle {
    string public name;
    uint public speed;

    constructor(string memory _name, uint _speed) {
        name = _name;
        speed = _speed;
    }

    function move() public virtual returns (string memory) {
        return "Vehicle is moving";
    }

    function stop() public pure returns (string memory) {
        return "Vehicle has stopped";
    }
}

// Derived contract: Car (inherits from Vehicle)
contract Car is Vehicle {
    uint public numberOfDoors;

    constructor(string memory _name, uint _speed, uint _numberOfDoors) Vehicle(_name, _speed) {
        numberOfDoors = _numberOfDoors;
    }

    // Override the move function
    function move() public pure override returns (string memory) {
        return "Car is moving on the road";
    }
}

// Derived contract: Bicycle (inherits from Vehicle)
contract Bicycle is Vehicle {
    uint public numberOfGears;

    constructor(string memory _name, uint _speed, uint _numberOfGears) Vehicle(_name, _speed) {
        numberOfGears = numberOfGears;
    }

    // Override the move function
    function move() public pure override returns (string memory) {
        return "Bicycle is moving on the path";
    }
}

// Derived contract: ElectricCar (inherits from Car)
contract ElectricCar is Car {
    uint public batteryCapacity;

    constructor(string memory _name, uint _speed, uint _numberOfDoors, uint _batteryCapacity)
        Car(_name, _speed, _numberOfDoors)
    {
        batteryCapacity = _batteryCapacity;
    }

    // Override the move function
    function move() public pure override returns (string memory) {
        return "Electric car is moving silently";
    }
}
```

---

##### **What to Do**:
1. **Deploy the Contracts**:
   - Deploy the `Car`, `Bicycle`, and `ElectricCar` contracts in Remix.

2. **Test the Functions**:
   - Call the `move` and `stop` functions on each contract to see how they behave.
     - Example:
       ```solidity
       Car myCar = new Car("Tesla", 120, 4);
       myCar.move(); // Returns "Car is moving on the road"
       myCar.stop(); // Returns "Vehicle has stopped"
       ```

3. **Observe Inheritance**:
   - Check the inherited state variables (`name`, `speed`) and functions (`stop`).

4. **Test Function Overriding**:
   - Call the `move` function on `ElectricCar` to see the overridden behavior.
     ```solidity
     ElectricCar myElectricCar = new ElectricCar("Tesla Model S", 150, 4, 100);
     myElectricCar.move(); // Returns "Electric car is moving silently"
     ```

---

##### **Key Features**:
- **Inheritance**: `Car` and `Bicycle` inherit from `Vehicle`, and `ElectricCar` inherits from `Car`.
- **Function Overriding**: Each derived contract overrides the `move` function to provide specific behavior.
- **Modularity**: Common functionality is defined in the base contract (`Vehicle`) and reused in derived contracts.

---

#### **4. Best Practices for Inheritance**
- Use inheritance to promote code reuse and modularity.
- Override functions only when necessary to provide specific behavior.
- Avoid deep inheritance hierarchies to keep the code simple and maintainable.
- Use `virtual` and `override` keywords explicitly to avoid ambiguity.

---

#### **Summary of Day 11**
- Learned about **inheritance** and how to create parent and child contracts.
- Explored **function overriding** to customize behavior in derived contracts.
- Built a `Vehicle` contract hierarchy to demonstrate inheritance and modularity.
- Practiced deploying and testing contracts with inheritance.

By the end of Day 11, you should be comfortable using inheritance to create modular and reusable smart contracts. Tomorrow, we’ll dive into more advanced topics like error handling and contract interactions!
