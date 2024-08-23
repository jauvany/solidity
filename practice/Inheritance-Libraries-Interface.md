### Practice Exercises for Solidity's Advanced Features

#### **1. Exercise: Inheritance**

**Objective:** Create a set of contracts that demonstrate how inheritance works in Solidity, including function overriding.

**Step-by-Step Instructions:**

1. **Step 1:** Create a base contract called `Animal`:
   - Add a public function `sound()` that returns a generic string `"Animal sound"`.

   ```solidity
   contract Animal {
       function sound() public pure virtual returns (string memory) {
           return "Animal sound";
       }
   }
   ```

2. **Step 2:** Create a derived contract called `Dog` that inherits from `Animal`:
   - Override the `sound()` function to return `"Bark"`.

   ```solidity
   contract Dog is Animal {
       function sound() public pure override returns (string memory) {
           return "Bark";
       }
   }
   ```

3. **Step 3:** Create another derived contract called `Cat` that also inherits from `Animal`:
   - Override the `sound()` function to return `"Meow"`.

   ```solidity
   contract Cat is Animal {
       function sound() public pure override returns (string memory) {
           return "Meow";
       }
   }
   ```

4. **Step 4:** Deploy the `Dog` and `Cat` contracts and call their `sound()` functions:
   - Verify that the `Dog` contract returns `"Bark"` and the `Cat` contract returns `"Meow"`.

**Expected Outcome:** You should see the correct sound for each animal, demonstrating function overriding and inheritance.

#### **2. Exercise: Libraries**

**Objective:** Implement a library for performing basic arithmetic operations and use it within a contract.

**Step-by-Step Instructions:**

1. **Step 1:** Create a library called `ArithmeticLib`:
   - Add functions `add`, `subtract`, `multiply`, and `divide` that perform basic arithmetic operations.

   ```solidity
   library ArithmeticLib {
       function add(uint a, uint b) public pure returns (uint) {
           return a + b;
       }

       function subtract(uint a, uint b) public pure returns (uint) {
           return a - b;
       }

       function multiply(uint a, uint b) public pure returns (uint) {
           return a * b;
       }

       function divide(uint a, uint b) public pure returns (uint) {
           require(b > 0, "Division by zero");
           return a / b;
       }
   }
   ```

2. **Step 2:** Create a contract called `Calculator`:
   - Use the `using for` directive to attach the `ArithmeticLib` functions to the `uint` type.

   ```solidity
   contract Calculator {
       using ArithmeticLib for uint;

       function calculate() public pure returns (uint) {
           uint a = 10;
           uint b = 2;
           return a.add(b); // Example of using the library
       }
   }
   ```

3. **Step 3:** Add functions in the `Calculator` contract to call each arithmetic operation (e.g., `add`, `subtract`, `multiply`, `divide`).

   ```solidity
   function calculateAddition(uint a, uint b) public pure returns (uint) {
       return a.add(b);
   }

   function calculateSubtraction(uint a, uint b) public pure returns (uint) {
       return a.subtract(b);
   }

   function calculateMultiplication(uint a, uint b) public pure returns (uint) {
       return a.multiply(b);
   }

   function calculateDivision(uint a, uint b) public pure returns (uint) {
       return a.divide(b);
   }
   ```

4. **Step 4:** Deploy the `Calculator` contract and test each arithmetic function.

**Expected Outcome:** The `Calculator` contract should correctly perform the arithmetic operations using the `ArithmeticLib` library.

#### **3. Exercise: Interfaces**

**Objective:** Create an interface and implement it in a contract to demonstrate how interfaces work in Solidity.

**Step-by-Step Instructions:**

1. **Step 1:** Create an interface called `IVehicle`:
   - Define a function `start()` that does not take any parameters and returns a string.

   ```solidity
   interface IVehicle {
       function start() external returns (string memory);
   }
   ```

2. **Step 2:** Create a contract called `Car` that implements the `IVehicle` interface:
   - Implement the `start()` function to return the string `"Car is starting"`.

   ```solidity
   contract Car is IVehicle {
       function start() external override returns (string memory) {
           return "Car is starting";
       }
   }
   ```

3. **Step 3:** Create another contract called `Motorcycle` that also implements the `IVehicle` interface:
   - Implement the `start()` function to return the string `"Motorcycle is starting"`.

   ```solidity
   contract Motorcycle is IVehicle {
       function start() external override returns (string memory) {
           return "Motorcycle is starting";
       }
   }
   ```

4. **Step 4:** Deploy the `Car` and `Motorcycle` contracts and call their `start()` functions:
   - Verify that the `Car` contract returns `"Car is starting"` and the `Motorcycle` contract returns `"Motorcycle is starting"`.

**Expected Outcome:** The `Car` and `Motorcycle` contracts should correctly implement the `IVehicle` interface, returning the appropriate start messages.