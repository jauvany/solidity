### **Day 12: Abstract Contracts and Interfaces in Solidity**

Today, you’ll learn about **abstract contracts** and **interfaces** in Solidity. These are powerful tools for defining structure and behavior without implementation, enabling modular and reusable code. You’ll also practice creating an abstract contract and implementing it in a child contract.

---

#### **1. Abstract Contracts**
An abstract contract is a contract that contains at least one function without implementation (marked with the `virtual` keyword). It cannot be deployed directly and must be inherited by a child contract that provides the implementation.

- **Key Features**:
  - Defines a structure or blueprint for derived contracts.
  - Can contain both implemented and unimplemented functions.
  - Cannot be instantiated or deployed.

- **Syntax**:
  ```solidity
  abstract contract MyAbstractContract {
      function myFunction() public virtual; // Unimplemented function
  }
  ```

---

#### **2. Interfaces**
An interface is similar to an abstract contract but is more restrictive. It can only declare function signatures (no implementation or state variables) and is used to define a standard set of functions that other contracts must implement.

- **Key Features**:
  - Cannot contain any implemented functions or state variables.
  - Used to enforce a standard API for contracts.
  - Can be inherited by other interfaces or contracts.

- **Syntax**:
  ```solidity
  interface MyInterface {
      function myFunction() external; // Function signature
  }
  ```

---

#### **3. Practice: Create an Abstract Contract and Implement It**
Let’s build an abstract contract and a child contract that implements it.

---

##### **Abstract Contract: Shape**
This abstract contract defines a blueprint for geometric shapes.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract Shape {
    // Unimplemented function to calculate area
    function calculateArea() public virtual returns (uint);

    // Unimplemented function to calculate perimeter
    function calculatePerimeter() public virtual returns (uint);

    // Implemented function to display shape type
    function getShapeType() public pure virtual returns (string memory) {
        return "Generic Shape";
    }
}
```

---

##### **Child Contract: Rectangle**
This contract implements the `Shape` abstract contract for a rectangle.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Rectangle is Shape {
    uint public length;
    uint public width;

    constructor(uint _length, uint _width) {
        length = _length;
        width = _width;
    }

    // Implement calculateArea for Rectangle
    function calculateArea() public override returns (uint) {
        return length * width;
    }

    // Implement calculatePerimeter for Rectangle
    function calculatePerimeter() public override returns (uint) {
        return 2 * (length + width);
    }

    // Override getShapeType for Rectangle
    function getShapeType() public pure override returns (string memory) {
        return "Rectangle";
    }
}
```

---

##### **What to Do**:
1. **Deploy the `Rectangle` Contract**:
   - Deploy the `Rectangle` contract in Remix with specific dimensions (e.g., `length = 5`, `width = 10`).

2. **Test the Functions**:
   - Call `calculateArea` to compute the area of the rectangle.
     ```solidity
     calculateArea(); // Returns 50 (5 * 10)
     ```
   - Call `calculatePerimeter` to compute the perimeter of the rectangle.
     ```solidity
     calculatePerimeter(); // Returns 30 (2 * (5 + 10))
     ```
   - Call `getShapeType` to get the type of the shape.
     ```solidity
     getShapeType(); // Returns "Rectangle"
     ```

3. **Observe Inheritance**:
   - Check how the `Rectangle` contract implements the functions defined in the `Shape` abstract contract.

---

#### **4. Advanced Example: Using Interfaces**
Let’s create an interface and implement it in a contract.

---

##### **Interface: IShape**
This interface defines a standard set of functions for geometric shapes.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IShape {
    function calculateArea() external returns (uint);
    function calculatePerimeter() external returns (uint);
    function getShapeType() external pure returns (string memory);
}
```

---

##### **Contract: Circle**
This contract implements the `IShape` interface for a circle.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Circle is IShape {
    uint public radius;

    constructor(uint _radius) {
        radius = _radius;
    }

    // Implement calculateArea for Circle
    function calculateArea() public override returns (uint) {
        return 3 * radius * radius; // Approximation of π * r^2
    }

    // Implement calculatePerimeter for Circle
    function calculatePerimeter() public override returns (uint) {
        return 2 * 3 * radius; // Approximation of 2 * π * r
    }

    // Implement getShapeType for Circle
    function getShapeType() public pure override returns (string memory) {
        return "Circle";
    }
}
```

---

##### **What to Do**:
1. **Deploy the `Circle` Contract**:
   - Deploy the `Circle` contract in Remix with a specific radius (e.g., `radius = 7`).

2. **Test the Functions**:
   - Call `calculateArea` to compute the area of the circle.
     ```solidity
     calculateArea(); // Returns 147 (3 * 7 * 7)
     ```
   - Call `calculatePerimeter` to compute the perimeter of the circle.
     ```solidity
     calculatePerimeter(); // Returns 42 (2 * 3 * 7)
     ```
   - Call `getShapeType` to get the type of the shape.
     ```solidity
     getShapeType(); // Returns "Circle"
     ```

3. **Observe Interface Implementation**:
   - Check how the `Circle` contract implements the functions defined in the `IShape` interface.

---

#### **5. Best Practices for Abstract Contracts and Interfaces**
- Use **abstract contracts** to define a blueprint for derived contracts.
- Use **interfaces** to enforce a standard API for contracts.
- Keep abstract contracts and interfaces simple and focused on a single responsibility.
- Use `virtual` and `override` keywords to explicitly define function behavior.

---

#### **Summary of Day 12**
- Learned about **abstract contracts** and how they define structure without implementation.
- Explored **interfaces** and their use in enforcing standard APIs.
- Built an abstract contract (`Shape`) and implemented it in a child contract (`Rectangle`).
- Created an interface (`IShape`) and implemented it in a contract (`Circle`).

By the end of Day 12, you should be comfortable using abstract contracts and interfaces to create modular and reusable smart contracts. Tomorrow, we’ll dive into more advanced topics like error handling and contract interactions!
