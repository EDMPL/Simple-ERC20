// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from 'forge-std/Script.sol';
import {ZeppelinToken} from 'src/ZeppelinToken.sol';

contract DeployZeppelinToken is Script {
    uint256 public constant INITIAL_SUPPLY = 1000 ether;
    function run() external returns (ZeppelinToken) {
        vm.startBroadcast();
        ZeppelinToken zt = new ZeppelinToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return zt;
    }
}