// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {MerkleAirdrop} from "src/MerkleAirdrop.sol";
import {BagelToken} from "src/BagelToken.sol";
import {DeployMerkleAirdrop} from "script/DeployMerkleAirdrop.s.sol";
import {ZkSyncChainChecker} from "lib/foundry-devops/src/ZkSyncChainChecker.sol";

contract MerkleAirdropTest is Test, ZkSyncChainChecker {
    BagelToken public bagel;
    MerkleAirdrop public airdrop;
    bytes32 public constant ROOT = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    address public user;
    uint256 public userPrivateKey;
    address public gasPayer;
    uint256 public constant AMOUNT_TO_CLAIM = 25e18;
    uint256 public constant AMOUNT_TO_SEND = 4 * AMOUNT_TO_CLAIM;
    bytes32[] public PROOF = [
        bytes32(0x0fd7c981d39bece61f7499702bf59b3114a90e66b51ba2c53abdf7b62986c00a),
        bytes32(0xe5ebd1e1b5a5478a944ecab36a9a954ac3b6b8216875f6524caa7a1d87096576)
    ];

    function setUp() public {
        if (isZkSyncChain()) {
            bagel = new BagelToken();
            airdrop = new MerkleAirdrop(ROOT, bagel);
            bagel.mint(bagel.owner(), AMOUNT_TO_SEND);
            bagel.transfer(address(airdrop), AMOUNT_TO_SEND);
        } else {
            DeployMerkleAirdrop deployer = new DeployMerkleAirdrop();
            (airdrop, bagel) = deployer.run();
        }
        (user, userPrivateKey) = makeAddrAndKey("user");
        gasPayer = makeAddr("gaspayer");
        console.log("user address: ", user);
        console.log("gas payer: ", gasPayer);
    }

    function testUserCanClaim() public {
        uint256 startingbalance = bagel.balanceOf(user);
        bytes32 digest = airdrop.getMessageHash(user, AMOUNT_TO_CLAIM);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(userPrivateKey, digest);
        vm.prank(gasPayer);
        airdrop.claim(user, AMOUNT_TO_CLAIM, PROOF, v, r, s);
        uint256 endingBalance = bagel.balanceOf(user);
        assert(endingBalance == startingbalance + AMOUNT_TO_CLAIM);
    }
}
