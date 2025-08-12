// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import {Script} from "forge-std/Script.sol";
import {BagelToken} from "../src/BagelToken.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DeployMerkleAirdrop is Script {
    bytes32 private constant ROOT = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 public constant AMOUNT = 25 * 1e18;

    function run() external returns (BagelToken, MerkleAirdrop) {
        vm.startBroadcast();
        BagelToken bagelToken = new BagelToken();
        MerkleAirdrop merkleAirdrop = new MerkleAirdrop(ROOT, bagelToken);
        bagelToken.mint(bagelToken.owner(), AMOUNT * 4);
        bagelToken.transfer(address(merkleAirdrop), AMOUNT * 4);
        vm.stopBroadcast();
        return (bagelToken, merkleAirdrop);
    }
}
