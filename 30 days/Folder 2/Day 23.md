### **Day 23: Event Handling in DApps – Listening to Smart Contract Events**  

Today, you'll learn how to **listen for smart contract events** in a **DApp** and update the UI in real time. Events are crucial for tracking on-chain activity without repeatedly querying the blockchain.

---

## **1️⃣ Understanding Smart Contract Events**  

Events allow smart contracts to **emit logs** that external applications (like a frontend DApp) can listen to.  

### **Example Smart Contract with Events (Solidity)**  
Let's create a simple **Ethereum smart contract** that emits an event when **Ether is sent**.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract PaymentContract {
    event PaymentReceived(address indexed sender, uint amount);

    function sendPayment() public payable {
        require(msg.value > 0, "Must send some ETH");
        emit PaymentReceived(msg.sender, msg.value);
    }
}
```
- **`event PaymentReceived(address indexed sender, uint amount);`** → Defines an event.  
- **`emit PaymentReceived(msg.sender, msg.value);`** → Triggers the event when a payment is received.

---

## **2️⃣ Deploy the Smart Contract**  
Deploy your contract on a **testnet** (Goerli, Sepolia) using **Remix** or **Hardhat**.

---

## **3️⃣ Listening to Events in a React DApp**  

### **Step 1: Install Dependencies**  
If you haven't installed Ethers.js:  
```bash
npm install ethers
```

### **Step 2: Connect to the Smart Contract**  
Modify your `App.js` file:

```javascript
import { useEffect, useState } from "react";
import { ethers } from "ethers";

const contractAddress = "0xYourContractAddressHere"; // Replace with deployed contract address
const abi = [
  {
    "anonymous": false,
    "inputs": [
      { "indexed": true, "internalType": "address", "name": "sender", "type": "address" },
      { "indexed": false, "internalType": "uint256", "name": "amount", "type": "uint256" }
    ],
    "name": "PaymentReceived",
    "type": "event"
  }
];

function App() {
  const [payments, setPayments] = useState([]);

  useEffect(() => {
    const listenToEvents = async () => {
      if (window.ethereum) {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const contract = new ethers.Contract(contractAddress, abi, provider);

        contract.on("PaymentReceived", (sender, amount) => {
          setPayments((prevPayments) => [
            ...prevPayments,
            { sender, amount: ethers.utils.formatEther(amount) }
          ]);
        });
      }
    };

    listenToEvents();
    return () => contract.removeAllListeners("PaymentReceived"); // Cleanup
  }, []);

  return (
    <div>
      <h1>Event Listener</h1>
      <ul>
        {payments.map((tx, index) => (
          <li key={index}>
            <b>{tx.sender}</b> sent <b>{tx.amount} ETH</b>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
```

---

## **4️⃣ How It Works**
- **Connects to the blockchain** via `ethers.js`
- **Listens for the `PaymentReceived` event** emitted by the smart contract
- **Updates the UI dynamically** when a new transaction occurs  

---

## **🎯 Practice Task:**  
- ✅ Modify your frontend to show the last **5 transactions**  
- ✅ Display the **timestamp** of each transaction  
- ✅ Deploy your DApp to a testnet  

Let me know if you need help! 🚀

Let's cover Day 23: Event handling in dApps.  Listening to and reacting to smart contract events is crucial for building dynamic and responsive dApps.  We'll use ethers.js for this.

**I. Understanding Smart Contract Events**

Events are a way for smart contracts to communicate information to the outside world.  When an event is emitted by a contract, it's recorded in the transaction logs.  Your dApp can listen for these events and react accordingly (e.g., update the UI, trigger other actions).

**II. Setting Up for Event Listening**

1. **Contract Instance:** You'll need an instance of your contract (as covered in previous days).

```javascript
import { ethers } from 'ethers';
// ... other imports

const contract = new ethers.Contract(contractAddress, contractABI, signer); // signer is needed if listening to events from a user interaction
const provider = new ethers.providers.JsonRpcProvider("YOUR_ALCHEMY_OR_INFURA_URL"); // provider is needed if listening to events without user interaction
const contractReadOnly = new ethers.Contract(contractAddress, contractABI, provider); // provider is needed if listening to events without user interaction
```

2. **Event Filtering (Optional but Recommended):**  You can filter events based on specific criteria (e.g., specific indexed parameters).  This is important for efficiency, especially if your contract emits many events.

**III. Listening for Events (ethers.js)**

```javascript
import { useState, useEffect } from 'react';
import { ethers } from 'ethers';
// ... other imports

function MyComponent() {
  const [eventData, setEventData] = useState([]); // Store event data

  useEffect(() => {
    if (contract) { // Only start listening if the contract instance exists
      const filter = contract.filters.MyEvent(null, null); // Example filter (replace MyEvent and parameters)

      // Listen for the event
      contract.on(filter, (param1, param2, event) => { // Replace param1, param2 with your event's parameters
        console.log("Event emitted:", param1, param2, event);
        setEventData(prevData => [...prevData, { param1, param2 }]); // Update state with event data
      });

      // It's a good practice to clean up the listener when the component unmounts
      return () => {
        contract.off(filter); // Remove the listener
      }
    }
  }, [contract]); // The effect depends on the contract instance

  // ... rest of your component code
}

export default MyComponent;
```

**Explanation:**

1. **`contract.filters.MyEvent(null, null)`:** Creates a filter for the `MyEvent` event.  The `null` values mean we're not filtering on any specific indexed parameters (if any). Replace `MyEvent` with the name of your event and the parameters with the indexed parameters you want to filter. If you want to listen to all events of this type, pass `null` as arguments, as shown in the example.
2. **`contract.on(filter, (param1, param2, event) => { ... });`:** Sets up an event listener.  The callback function is executed whenever the `MyEvent` is emitted and matches the filter. `param1`, `param2`, and other parameters are the values of the event's indexed parameters. The last parameter, `event`, contains additional information about the event, such as the transaction hash and block number.
3. **`setEventData(...)`:** Updates the component's state with the event data.  This will trigger a re-render, updating the UI.
4. **`contract.off(filter)`:** Removes the event listener when the component unmounts.  This is *very important* to prevent memory leaks.  It's done in the cleanup function of the `useEffect` hook.
5. **`useEffect` dependency:** The `useEffect` hook now depends on the `contract` instance.  This ensures that the event listener is set up only after the contract instance is available (e.g., after the user connects their wallet).

**IV. Displaying Event Data in the UI**

```javascript
// ... (previous code)

return (
  <div>
    {/* ... other JSX */}
    <h2>Events:</h2>
    <ul>
      {eventData.map((event, index) => (
        <li key={index}>
          Param1: {event.param1}, Param2: {event.param2} {/* Display event data */}
        </li>
      ))}
    </ul>
  </div>
);
```

**V. Example Smart Contract (Emitting an Event)**

```solidity
pragma solidity ^0.8.0;

contract MyContract {
  event MyEvent(address indexed from, uint256 indexed amount); // Define the event

  function myFunction(uint256 amount) public {
    // ... your logic
    emit MyEvent(msg.sender, amount); // Emit the event
  }
}
```

**VI. Key Considerations**

* **Indexed Parameters:**  Use `indexed` parameters in your events to make them more searchable and filterable.
* **Event Names:** Choose descriptive names for your events.
* **Cleanup:** Always remove event listeners when your component unmounts to prevent memory leaks.
* **Filtering:** Use filters to listen for specific events or events with specific parameters.  This makes your dApp more efficient.
* **User Experience:** Design your UI to clearly display event data to the user.

**VII. Practice: Listening for Events**

1. **Deploy a Contract:** Deploy a contract that emits an event (like the example above) to a testnet.
2. **Set Up React App:** Create a React app and install ethers.js.
3. **Connect to MetaMask:** Implement the connection logic.
4. **Listen for Events:** Implement the event listening logic using `contract.on()`.
5. **Update UI:** Update the UI to display the event data.  For example, you could display the event parameters in a list.

This guide provides a solid foundation for handling events in your dApps.  Remember to practice and experiment to gain proficiency.  Events are essential for building interactive and real-time dApps, allowing your UI to react to changes in your smart contracts.
