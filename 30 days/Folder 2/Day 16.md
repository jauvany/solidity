# Day 16-20: Smart Contract Security

Let's tackle Day 16: Re-entrancy attacks and their prevention.  This is a *critical* security concept in smart contract development.  Understanding and mitigating re-entrancy vulnerabilities is essential for building secure dApps.

**I. What is a Re-entrancy Attack?**

A re-entrancy attack occurs when a malicious contract calls a vulnerable function in another contract, and that function, before finishing its execution, calls back into the malicious contract. This can lead to unexpected behavior, such as draining funds or manipulating contract state.

**Analogy:** Imagine a bank where you can withdraw money.  A malicious actor could withdraw some money, and *before* the bank updates your balance, they call the withdrawal function *again*.  If the bank isn't careful, they might allow the second withdrawal, even though the initial withdrawal hasn't been fully processed yet, effectively allowing the attacker to withdraw more than they should be able to.

**II. Example of a Vulnerable Contract**

```solidity
pragma solidity ^0.8.0;

contract VulnerableBank {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient funds");

        balances[msg.sender] -= amount;

        // Vulnerable line: External call BEFORE updating the balance
        (bool success, ) = msg.sender.call{value: amount}(""); // Send Ether

        require(success, "Transfer failed");  // Unlikely to catch a reentrancy
    }
}

contract Attacker {
    VulnerableBank public bank;

    constructor(address _bank) {
        bank = VulnerableBank(_bank);
    }

    function attack() public {
        bank.deposit{value: 1 ether}(); // Fund the attack
        bank.withdraw(1 ether); // Start the attack - triggers the fallback function
    }

    fallback() external payable {  // The reentrancy point
        if (address(bank).balance >= 1 ether) {
           bank.withdraw(1 ether); // Call withdraw AGAIN!
        }
    }
}
```

**How the Attack Works:**

1. The `Attacker` contract calls `VulnerableBank.withdraw()`.
2. The `VulnerableBank` reduces the attacker's balance.
3. The `VulnerableBank` calls `msg.sender.call{value: amount}("")` to send the Ether to the attacker.
4. This call triggers the `Attacker`'s `fallback()` function.
5. Inside the `fallback()`, the `Attacker` calls `VulnerableBank.withdraw()` *again* before the first withdrawal has finished.
6. The `VulnerableBank` (because it hasn't updated the balance yet) sees that the attacker *still* has sufficient funds (from the first withdrawal request).  The attacker is effectively able to withdraw more funds, because the contract does not yet realize that they already tried to withdraw the same amount of money.
7. Steps 4-6 repeat, draining the `VulnerableBank` contract.

**III. Preventing Re-entrancy Attacks**

Here are the most common and effective prevention techniques:

**A. Checks-Effects-Interactions Pattern:**

This is the *most recommended* approach. Structure your functions so that:

1. **Checks:** Perform all necessary checks (e.g., balance checks, input validation) *before* making any changes to the contract state.
2. **Effects:** Update the contract state (e.g., modify balances) *before* interacting with external contracts.
3. **Interactions:**  Make external calls (e.g., sending Ether) *after* updating the state.

**B. Re-entrancy Guard (Mutex):**

Use a state variable to lock the critical section of your code.  While the lock is active, the function cannot be re-entered.

```solidity
uint256 private lock; // 1 means locked, 0 means unlocked

modifier noReentrant() {
    require(lock == 0, "ReentrancyGuard: reentrant call");
    lock = 1;
    _; // Execute the function
    lock = 0;
}

function withdraw(uint256 amount) public noReentrant { // Apply the modifier!
    // ... (rest of the withdraw function as before)
}
```

**C. Limiting External Calls:**  Avoid making external calls within critical functions if possible.  If you can perform calculations and state updates before the external call, do so.

**IV. Fixing the Vulnerable Contract**

Let's apply the Checks-Effects-Interactions pattern:

```solidity
pragma solidity ^0.8.0;

contract SecureBank {
    mapping(address => uint256) public balances;

    function

    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient funds");

        // 1. Checks: Balance check already done above.
        // 2. Effects: Update the balance FIRST
        balances[msg.sender] -= amount;

        // 3. Interactions:  NOW make the external call
        (bool success, ) = payable(msg.sender).transfer(amount); // Use transfer - it reverts!
        require(success, "Transfer failed");
    }
}
```

By changing the order of operations, the attacker's `fallback()` function will no longer be able to drain the contract, because by the time the external `transfer` reaches the attacker, it has already been correctly reflected in the contract's data that their funds are no longer sufficient to initiate another withdraw request, therefore, a reentrancy attack will fail.

**Key Takeaways:**

* Re-entrancy attacks are a serious threat.
* The Checks-Effects-Interactions pattern is the most effective way to prevent them.
* Always prioritize security in your smart contract development.

This example provides a good starting point.  Always test your contracts thoroughly and consider using formal verification tools for added security, especially when dealing with high-value assets.
