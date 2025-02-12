### **Day 22: Integrating Web3.js or Ethers.js into a DApp**  
Today, you’ll integrate **Web3.js** or **Ethers.js** into your **DApp** to send and receive transactions from the frontend. By the end, you'll connect your DApp to a **testnet** and send Ether from a web interface.

---

### **1️⃣ Choosing Between Web3.js and Ethers.js**  
Both libraries allow interaction with Ethereum:  
- **Web3.js** (by Ethereum Foundation)  
- **Ethers.js** (lightweight, better for React)

For this lesson, we'll use **Ethers.js**.

---

### **2️⃣ Setting Up Your DApp**  
#### **Step 1: Install Dependencies**  
If you haven't installed Ethers.js, run:  
```bash
npm install ethers
```

#### **Step 2: Connect MetaMask**  
Modify your `App.js`:  
```javascript
import { useState } from "react";
import { ethers } from "ethers";

function App() {
  const [account, setAccount] = useState("");
  const [balance, setBalance] = useState("0");

  async function connectWallet() {
    if (window.ethereum) {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const signer = provider.getSigner();
      const address = await signer.getAddress();
      setAccount(address);

      // Get balance
      const balance = await provider.getBalance(address);
      setBalance(ethers.utils.formatEther(balance));
    } else {
      alert("MetaMask not detected!");
    }
  }

  return (
    <div>
      <h1>Web3 Transactions</h1>
      <button onClick={connectWallet}>Connect Wallet</button>
      {account && <p>Connected: {account} - Balance: {balance} ETH</p>}
    </div>
  );
}

export default App;
```

---

### **3️⃣ Sending ETH from the Frontend**  
Modify `App.js` to add a function that **sends ETH**.

```javascript
async function sendTransaction() {
  if (!account) return alert("Connect your wallet first!");

  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const signer = provider.getSigner();

  const tx = await signer.sendTransaction({
    to: "0xReceiverAddressHere", // Replace with a testnet address
    value: ethers.utils.parseEther("0.01"),
  });

  alert(`Transaction sent! TX Hash: ${tx.hash}`);
}
```

**Add a button to trigger the transaction:**
```html
<button onClick={sendTransaction}>Send 0.01 ETH</button>
```

---

### **4️⃣ Deploying to a Testnet**  
✅ **Use a testnet (Goerli, Sepolia, etc.)**  
✅ **Get free test ETH** from a faucet: [https://goerlifaucet.com/](https://goerlifaucet.com/)  
✅ **Try sending transactions on testnet**  

---

### **🎯 Practice Task:**  
- ✅ Modify your DApp to input a **custom recipient address** and **amount**  
- ✅ Deploy and interact with it on a testnet  

Let me know if you need any help! 🚀

Let's focus on Day 22: Integrating Web3.js or Ethers.js into a DApp, specifically for sending and receiving transactions.  We'll build upon the previous day's React setup. I'll provide examples using ethers.js, as it's the generally preferred library.

**I. Project Setup (Assuming you have a React app)**

1. **Install Ethers.js:** If you haven't already:

```bash
npm install ethers
```

2. **Import Ethers.js:** In your component:

```javascript
import { ethers } from 'ethers';
```

**II. Connecting to MetaMask and Getting Accounts**

```javascript
import { useState, useEffect } from 'react';
import { ethers } from 'ethers';

function MyComponent() {
  const [account, setAccount] = useState(null);
  const [provider, setProvider] = useState(null);
  const [signer, setSigner] = useState(null);

  useEffect(() => {
    async function connectWallet() {
      if (window.ethereum) {
        try {
          const provider = new ethers.providers.Web3Provider(window.ethereum);
          await provider.send("eth_requestAccounts", []); // Request account access
          const signer = provider.getSigner();
          const address = await signer.getAddress();

          setAccount(address);
          setProvider(provider);
          setSigner(signer); // Store the signer for later use

        } catch (error) {
          console.error("Error connecting:", error);
        }
      } else {
        console.log("Please install MetaMask!");
      }
    }

    connectWallet(); // Call on component mount
  }, []); // Empty dependency array ensures this runs only once

  // ... rest of your component code
}

export default MyComponent;

```

**III. Sending Transactions (Sending Ether)**

```javascript
import { useState, useEffect } from 'react';
import { ethers } from 'ethers';

// ... (previous code for connection)

const sendEther = async (recipient, amount) => {
  if (!signer) {
    console.error("Not connected!");
    return;
  }

  try {
    const tx = await signer.sendTransaction({
      to: recipient,
      value: ethers.utils.parseEther(amount), // Convert amount to wei
    });

    await tx.wait(); // Wait for transaction confirmation
    console.log("Transaction sent:", tx.hash);
  } catch (error) {
    console.error("Error sending Ether:", error);
  }
};

// Example usage in your component's JSX:
<div>
  <input type="text" id="recipientAddress" placeholder="Recipient Address" />
  <input type="text" id="amount" placeholder="Amount (ETH)" />
  <button onClick={() => sendEther(document.getElementById("recipientAddress").value, document.getElementById("amount").value)}>
    Send Ether
  </button>
</div>
```

**Explanation:**

1. **`ethers.utils.parseEther(amount)`:** Converts the amount from ETH to wei (the smallest unit of Ether).  Crucial for correctly specifying the amount to send.
2. **`signer.sendTransaction()`:** Sends the transaction.  The `to` field specifies the recipient, and the `value` field specifies the amount in wei.
3. **`tx.wait()`:**  Waits for the transaction to be mined and confirmed.  Important to ensure the transaction has been successfully included in a block.
4. **Error Handling:** The `try...catch` block handles potential errors during the transaction process.

**IV. Reading Transaction Data**

After a transaction is sent (either by your DApp or externally), you'll likely want to read information about it.

```javascript
const getTransactionDetails = async (txHash) => {
  if (!provider) {
    console.error("Not connected!");
    return;
  }

  try {
    const tx = await provider.getTransaction(txHash);
    console.log("Transaction details:", tx);
    // Access various properties of the transaction object (tx)
    // e.g., tx.from, tx.to, tx.value, tx.blockNumber, etc.

    const receipt = await provider.getTransactionReceipt(txHash); // Get the transaction receipt
    console.log("Transaction receipt:", receipt);
    // Access various properties of the receipt, including gasUsed, status (success/failure)
  } catch (error) {
    console.error("Error getting transaction details:", error);
  }
};

// Example usage (assuming you have the txHash):
getTransactionDetails("0x...");
```

**V. Interacting with Smart Contract Functions**

This builds on Day 21, but it's essential to include it here for completeness.

```javascript
// ... (connection code)

// Assuming you have your contract ABI and address
const contract = new ethers.Contract(contractAddress, contractABI, signer);

const interactWithContract = async () => {
  try {
    const tx = await contract.myFunction(arg1, arg2, { value: ethers.utils.parseEther("0.1") }); // Example: Sending 0.1 ETH with the function call
    await tx.wait();
    console.log("Contract interaction successful:", tx.hash);

    const data = await contract.myVariable(); // Reading from contract
    console.log("Data from contract:", data.toString());

  } catch (error) {
    console.error("Error interacting with contract:", error);
  }
};
```

**VI. Key Improvements and Explanations**

* **Clearer Error Handling:** More specific error messages and better handling of connection and transaction errors.
* **Transaction Receipt:**  Added code to get the transaction receipt, which contains important information like gas used and the transaction's status (success or failure).
* **Sending Ether Example:**  A complete example of sending Ether, including converting the amount to wei.
* **Contract Interaction:**  Included an example of interacting with a contract function and sending Ether with the function call.
* **`useEffect` Hook:** The connection logic is now within `useEffect` to ensure it runs only on mount.
* **Signer:** The signer is now stored in state so it can be used for multiple transactions.


**VII. Practice: Connecting to the Testnet and Sending Ether**

1. **Deploy a Contract:** Deploy a simple contract to a testnet (Goerli, Sepolia).  Even a basic contract with a function that accepts Ether will work.
2. **Set Up React App:** Create a React app and install ethers.js.
3. **Connect to MetaMask:** Implement the connection logic to connect to MetaMask and get the user's account.
4. **Send Ether Form:** Create a form with input fields for the recipient address and amount.
5. **Send Transaction:** Implement the `sendEther` function to send Ether to the specified address.
6. **Test:** Connect to the testnet in MetaMask, get some test ETH from a faucet, and test your DApp.

This comprehensive guide should help you build a dApp that can send and receive transactions.  Remember to test thoroughly and always prioritize security best practices.  Building dApps is an iterative process, so start with simple functionality and gradually add more complex features.
