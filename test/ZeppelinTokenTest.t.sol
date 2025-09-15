// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from 'forge-std/Test.sol';
import {DeployZeppelinToken} from 'script/DeployZeppelinToken.s.sol';
import {ZeppelinToken} from 'src/ZeppelinToken.sol';

contract ZeppelinTokenTest is Test{
    ZeppelinToken public zToken;
    DeployZeppelinToken public deployer;

    address ed = makeAddr("Ed");
    address mal = makeAddr("Mal");

    uint256 public constant STARTING_BALANCE = 1000 ether;

    function setUp() public {
        deployer = new DeployZeppelinToken();
        zToken = deployer.run();

        vm.prank(msg.sender);
        zToken.transfer(ed, STARTING_BALANCE);
    }

    function testEdBalance() view public {
        assertEq(STARTING_BALANCE, zToken.balanceOf(ed));
    }

    function testAllowanceTransferFrom() public {
        uint256 initialAllowance = 1000 ether;
        uint256 transferAmount = 500 ether;

        vm.prank(ed);
        zToken.approve(mal, initialAllowance);

        vm.prank(mal);
        zToken.transferFrom(ed, mal, transferAmount);

        assertEq(zToken.balanceOf(mal), transferAmount);
        assertEq(zToken.balanceOf(ed), initialAllowance - transferAmount);
    }

      function testTransfer() public {
        uint256 transferAmount = 200 ether;

        vm.prank(ed);
        zToken.transfer(mal, transferAmount);

        assertEq(zToken.balanceOf(mal), transferAmount);
        assertEq(zToken.balanceOf(ed), STARTING_BALANCE - transferAmount);
    }

    function testBurnTokens() public {
        uint256 burnAmount = 300 ether;

        vm.prank(ed);
        zToken.burn(ed, burnAmount);

        assertEq(zToken.balanceOf(ed), STARTING_BALANCE - burnAmount);
        assertEq(zToken.totalSupply(), STARTING_BALANCE - burnAmount);
    }
}