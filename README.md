# MiniDAO - Decentralized Voting Contract

A minimalistic smart contract that allows DAO members to vote on proposals and update a public on-chain message.

Built as part of the **#100DaysOfSolidity** challenge by [Mariia Fialkovska](https://github.com/MariiaFi), this project demonstrates how to implement basic DAO logic without any external libraries.

---

## Features

- 1 address = 1 vote per proposal  
- Admin-only proposal creation  
- Proposals execute an actual change (update public message)  
- Configurable quorum  
- Emit events for all major actions

---

## Use Case

Imagine a community-driven dApp where users vote on daily slogans, feature priorities, or public announcements.  
This smart contract updates the `publicMessage` string **only if quorum is reached** and proposal is executed by the admin.

---

## Tech Stack

- **Solidity** `^0.8.30`
- **Remix IDE** (for testing)
- GitHub-ready for frontend integration with `ethers.js`, `wagmi`, or `web3.js`.

---

## Functions Overview

| Function             | Description                                                  |
|----------------------|--------------------------------------------------------------|
| `createProposal()`   | Admin creates a proposal with description and new message    |
| `vote()`             | Any address can vote once per proposal                       |
| `executeProposal()`  | Admin can execute proposal if quorum is met                  |
| `publicMessage`      | Returns current on-chain message                             |
| `getProposals()`     | View all proposals with their status                         |

---

## Remix Demo

1. **Deploy** with initial message and quorum:
   ```solidity
   new MiniDAO(3, "Welcome to the DAO")
   ```

2. **Create proposal**:
   ```solidity
   createProposal("Update slogan", "Decentralization is power")
   ```

3. **Vote** from multiple addresses:
   ```solidity
   vote(0)
   ```

4. **Execute** when quorum reached:
   ```solidity
   executeProposal(0)
   ```

5. **View result**:
   ```solidity
   publicMessage() // returns "Decentralization is power"
   ```

---

##  Ideas for Future Versions

- Voting deadline (block.timestamp + duration)  
- Token-weighted voting via ERC20 balance  
- Role-based proposal execution  
- Generic `bytes payload` for executing various actions

---

## License

MIT - use freely, fork openly, contribute if you like.

> Made by Mariia during #100DaysOfSolidity
