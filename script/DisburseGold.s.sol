// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { Script, console } from "forge-std/Script.sol";
import { CastleMap } from "src/CastleMap.sol";
import { IGasliteDrop } from "src/IGasliteDrop.sol";
import { Gold } from "src/Gold.sol";

contract DisburseGold is Script {

    Gold public gold = Gold(0x32Bf51fa408A0ee9B7A414C6A793760CaF086118);
    CastleMap public castleMap = CastleMap(0x95CE14EE82410C4a7296205e0c663969703Dc857);
    IGasliteDrop public gasliteDrop = IGasliteDrop(0x61684fc62B6a0f1273f69D9Fca0E264001a61Db6);

    
    function run() external {
        vm.startBroadcast();
        // gold.mint(0x6FaFF29226219756aa40CE648dbc65FB41DE5F72, 100000 * (1 ether));
        address[] memory castleList = castleMap.getAllTreasuryCastles();
        uint256[] memory allocations = new uint256[](castleList.length);
        uint256 totalAmount = 0;
        for (uint256 i = 0; i < allocations.length; i++) {
            allocations[i] = 10 ether;
            totalAmount += allocations[i];
        }
        // gold.approve(0x61684fc62B6a0f1273f69D9Fca0E264001a61Db6, totalAmount);
        gasliteDrop.airdropERC20(0x32Bf51fa408A0ee9B7A414C6A793760CaF086118, castleList, allocations, totalAmount);
        console.log("Disbursed: ", totalAmount);
        vm.stopBroadcast();
    }
}