On Day 25, you'll focus on connecting front-end forms to smart contracts, enabling users to submit data directly to the blockchain. This is a common use case for DApps, such as submitting votes, registering information, or updating decentralized databases.

Here’s a step-by-step guide to building a DApp where users can submit data to a smart contract:

---

### **Step 1: Set Up Your Development Environment**
1. **Install Node.js and npm**: Ensure you have Node.js and npm installed.
2. **Create a React App** (or use an existing one):
   ```bash
   npx create-react-app data-submission-dapp
   cd data-submission-dapp
   ```
3. **Install Ethers.js**:
   ```bash
   npm install ethers
   ```

---

### **Step 2: Write and Deploy a Smart Contract**
1. **Create a Smart Contract**:
   Write a simple Solidity contract that allows users to submit data. For example:
   ```solidity
   // SPDX-License-Identifier: MIT
   pragma solidity ^0.8.0;

   contract DataSubmission {
       struct Submission {
           address user;
           string data;
       }

       Submission[] public submissions;

       function submitData(string memory _data) public {
           submissions.push(Submission({
               user: msg.sender,
               data: _data
           }));
       }

       function getSubmissionCount() public view returns (uint256) {
           return submissions.length;
       }

       function getSubmission(uint256 index) public view returns (address, string memory) {
           require(index < submissions.length, "Submission does not exist");
           Submission memory submission = submissions[index];
           return (submission.user, submission.data);
       }
   }
   ```

2. **Compile and Deploy the Contract**:
   - Use [Remix](https://remix.ethereum.org/) or a local development environment like Hardhat or Truffle.
   - Deploy the contract to a testnet (e.g., Goerli or Sepolia) or a local blockchain (e.g., Ganache).

3. **Get the Contract ABI and Address**:
   After deployment, save the contract ABI and address. You'll need these to interact with the contract from your front-end.

---

### **Step 3: Build the Front-End Form**
1. **Create a Form Component**:
   In your React app, create a form where users can input data.
   ```jsx
   import React, { useState } from 'react';

   const DataForm = () => {
     const [data, setData] = useState('');

     const handleSubmit = async (e) => {
       e.preventDefault();
       // Submit data to the smart contract
       console.log("Submitting data:", data);
     };

     return (
       <form onSubmit={handleSubmit}>
         <input
           type="text"
           value={data}
           onChange={(e) => setData(e.target.value)}
           placeholder="Enter data"
           required
         />
         <button type="submit">Submit</button>
       </form>
     );
   };

   export default DataForm;
   ```

2. **Connect MetaMask**:
   Ensure the user is connected to MetaMask before submitting data.
   ```javascript
   const connectMetaMask = async () => {
     if (window.ethereum) {
       try {
         const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
         console.log("Connected account:", accounts[0]);
         return accounts[0];
       } catch (error) {
         console.error("User denied account access or error occurred:", error);
       }
     } else {
       alert("Please install MetaMask to use this DApp!");
     }
   };
   ```

---

### **Step 4: Submit Data to the Smart Contract**
1. **Initialize the Contract**:
   Use Ethers.js to interact with the deployed contract.
   ```javascript
   const submitDataToContract = async (data) => {
     const provider = new ethers.providers.Web3Provider(window.ethereum);
     const signer = provider.getSigner();

     // Replace with your contract's ABI and address
     const contractABI = [...];
     const contractAddress = "0xYourContractAddress";
     const contract = new ethers.Contract(contractAddress, contractABI, signer);

     // Call the submitData function
     const tx = await contract.submitData(data);
     await tx.wait();
     console.log("Data submitted successfully!");
   };
   ```

2. **Update the Form Submission Handler**:
   Call the `submitDataToContract` function when the form is submitted.
   ```javascript
   const handleSubmit = async (e) => {
     e.preventDefault();
     const userAddress = await connectMetaMask();
     if (userAddress) {
       await submitDataToContract(data);
       setData(''); // Clear the input field
     }
   };
   ```

---

### **Step 5: Display Submitted Data**
1. **Fetch Data from the Contract**:
   Add a function to retrieve and display submitted data.
   ```javascript
   const fetchSubmissions = async () => {
     const provider = new ethers.providers.Web3Provider(window.ethereum);
     const contractABI = [...];
     const contractAddress = "0xYourContractAddress";
     const contract = new ethers.Contract(contractAddress, contractABI, provider);

     const count = await contract.getSubmissionCount();
     const submissions = [];
     for (let i = 0; i < count; i++) {
       const submission = await contract.getSubmission(i);
       submissions.push(submission);
     }
     return submissions;
   };
   ```

2. **Display Data in the UI**:
   Use React state to store and display the fetched data.
   ```jsx
   const [submissions, setSubmissions] = useState([]);

   useEffect(() => {
     const loadSubmissions = async () => {
       const data = await fetchSubmissions();
       setSubmissions(data);
     };
     loadSubmissions();
   }, []);
   ```

   Render the submissions in your component:
   ```jsx
   <div>
     <h2>Submissions</h2>
     <ul>
       {submissions.map((submission, index) => (
         <li key={index}>
           <strong>{submission.user}</strong>: {submission.data}
         </li>
       ))}
     </ul>
   </div>
   ```

---

### **Step 6: Test Your DApp**
1. **Run Your DApp**:
   Start your development server.
   ```bash
   npm start
   ```
2. **Connect MetaMask**:
   Open your DApp in the browser, connect your MetaMask wallet, and ensure it's on the correct network.
3. **Submit Data**:
   Use the form to submit data and verify that it’s stored in the smart contract.
4. **View Submissions**:
   Check that the submitted data is displayed correctly in the UI.

---

### **Practice Task**
1. Extend the smart contract to include additional fields (e.g., a timestamp or category).
2. Add validation to the form to ensure data meets specific criteria.
3. Implement a feature to filter or sort submissions in the UI.

---

By the end of Day 25, you’ll have a functional DApp that allows users to submit data to a smart contract and view the submitted data. This is a foundational skill for building interactive and user-friendly decentralized applications!
