# Merkle-Airdrop

This project implements a **Merkle Airdrop** smart contract system. The project enables users to claim tokens based on their inclusion in a Merkle tree, ensuring both scalability and secure proof of membership.

## Project Structure

```plaintext
├── lib/
├── script/
│   ├── DeployMerkleAirdrop.s.sol       # Script for deploying contract
│   ├── GenerateInput.s.sol             # Script for generating input for Merkle tree
│   ├── Interactions.s.sol              # Script for contract interaction
│   ├── MakeMerkle.s.sol                # Script for generating Merkle tree
│   ├── SplitSignature.s.sol            # Script for splitting ECDSA signature
├── target/
│   ├── input.json                      # Input data for Merkle tree
│   ├── output.json                     # Output data for Merkle tree
├── src/
│   ├── BagelToken.sol                  # ERC20 token contract
│   ├── MerkleAirdrop.sol               # Merkle Airdrop smart contract
├── test/
│   ├── MerkleAirdropTest.t.sol         # Test file for Merkle Airdrop contract
├── zkout/
├── foundry.toml                        # Foundry configuration file
├── interactZK.sh                       # Shell script for interacting with zkSync
├── Makefile                            # Makefile for automating tasks
├── README.md                           # Project documentation (this file)
├── signature.txt                       # Example of signature data
```

## Project Components

- **src/**
  - `BagelToken.sol`: The ERC20 token contract used in the airdrop.
  - `MerkleAirdrop.sol`: The smart contract that facilitates the Merkle-based airdrop mechanism.

- **script/**
  - `DeployMerkleAirdrop.s.sol`: A script for deploying the MerkleAirdrop contract.
  - `GenerateInput.s.sol`: A script for generating input data for the Merkle tree.
  - `MakeMerkle.s.sol`: Used to generate a Merkle tree based on the input data.
  - `SplitSignature.s.sol`: Handles splitting of the ECDSA signature for verification purposes.

- **test/**
  - `MerkleAirdropTest.t.sol`: Contains tests for the Merkle Airdrop contract to verify correctness and security.

- **target/**
  - `input.json`: Contains the input data used to generate the Merkle tree.
  - `output.json`: Contains the resulting Merkle tree and proofs.

- **broadcast/**: 
  - Contains deployment and interaction scripts, including deployment and interaction logic for smart contracts.

## How to Run

1. **Compile the contracts**:
   ```bash
   forge build
   ```

2. **Run the tests**:
   ```bash
   forge test
   ```

3. **Deploy the contracts**:
   Use the provided deployment script located in the `script/` directory.
   ```bash
   forge script script/DeployMerkleAirdrop.s.sol --broadcast
   ```

4. **Interact with zkSync**:
   Use the provided `interactZK.sh` script to interact with the zkSync network.

## Merkle Airdrop Overview

The Merkle Airdrop uses a **Merkle Tree** to organize the airdrop distribution, ensuring that users can securely claim their tokens with the appropriate Merkle proof.

- **Merkle Tree**: A cryptographic structure that allows secure and scalable verification of token ownership using proofs.
- **Claiming Tokens**: Users provide a Merkle proof to verify their eligibility and claim tokens from the airdrop.

## Tools Used

- **Foundry**: A powerful toolchain for compiling, testing, and deploying smart contracts.
- **zkSync**: A Layer 2 scaling solution for Ethereum, ensuring faster and cheaper transactions.

## Example Usage

To claim tokens from the airdrop, users would use the following function:

```solidity
function claim(address account, uint256 amount, bytes32[] calldata merkleProof, uint8 v, bytes32 r, bytes32 s) external;
```

The proof would be generated using the scripts in the `script/` folder and verified against the Merkle root stored in the `MerkleAirdrop.sol` contract.

## License

This project is licensed under the MIT License.
