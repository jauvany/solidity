Here’s a basic ERC-721 NFT contract implementation using Solidity. This contract will allow users to mint and transfer NFTs.

### **Steps:**
1. **Install OpenZeppelin**: If you're using a local development environment, install OpenZeppelin contracts:  
   ```bash
   npm install @openzeppelin/contracts
   ```
2. **Write the ERC-721 Contract**
3. **Deploy and Test the Contract in Remix or Hardhat**

---

### **Basic ERC-721 NFT Contract**
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721URIStorage, Ownable {
    uint256 private _tokenIdCounter;

    constructor() ERC721("MyNFT", "MNFT") {}

    function mintNFT(address recipient, string memory tokenURI) public onlyOwner returns (uint256) {
        _tokenIdCounter++;
        uint256 newTokenId = _tokenIdCounter;
        
        _mint(recipient, newTokenId);
        _setTokenURI(newTokenId, tokenURI);

        return newTokenId;
    }
}
```

---

### **How It Works:**
- The contract **inherits** from OpenZeppelin's `ERC721URIStorage` (which includes metadata handling).
- `mintNFT`:
  - Increments `_tokenIdCounter` to generate a unique ID.
  - Mints a new NFT and assigns it to the `recipient`.
  - Sets a `tokenURI` (IPFS/metadata URL) to describe the NFT.
- **Only the owner** (deployer) can mint NFTs.

---

### **How to Deploy & Test in Remix**
1. **Copy the contract into Remix IDE**.
2. **Compile the contract** using Solidity 0.8.20+.
3. **Deploy using Remix’s JavaScript VM or Injected Provider (MetaMask)**.
4. **Mint an NFT**:
   - Call `mintNFT(recipient_address, "https://your-metadata-url.com/1")`.
   - Check `ownerOf(tokenId)` to verify ownership.

---

### **Next Steps**
- Integrate it with a DApp frontend using Web3.js or Ethers.js.
- Store NFT metadata on **IPFS** or Arweave.
- Add **royalty functionality** (EIP-2981) to earn commissions on resales.

Let me know if you need further improvements! 🚀
