// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script, console} from "forge-std/Script.sol";
import {MerkleAirdrop} from "src/MerkleAirdrop.sol";
import {BagelToken} from "src/BagelToken.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DeployMerkleAirdrop is Script {
    BagelToken public bagel;
    MerkleAirdrop public airdrop;
    bytes32 public constant MERKLE_ROOT = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 public constant AMOUNT_TO_AIRDROP = 4 * 25e18;

    function run() external returns (MerkleAirdrop, BagelToken) {
        return deployMerkleAirdrop();
    }

    function deployMerkleAirdrop() public returns (MerkleAirdrop, BagelToken) {
        vm.startBroadcast();
        bagel = new BagelToken();
        airdrop = new MerkleAirdrop(MERKLE_ROOT, bagel);
        bagel.mint(bagel.owner(), AMOUNT_TO_AIRDROP);
        bagel.transfer(address(airdrop), AMOUNT_TO_AIRDROP);
        vm.stopBroadcast();
        return (airdrop, bagel);
    }
}
