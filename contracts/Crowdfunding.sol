// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Crowdfunding {
    address public owner;
    uint public goal;
    uint public totalFunds;
    bool public goalReached;

    mapping(address => uint) public contributions;

    constructor(uint _goal) {
        owner = msg.sender;
        goal = _goal;
    }

    // Function 1: Contribute funds to the campaign
    function contribute() external payable {
        require(msg.value > 0, "Must send ETH to contribute");
        contributions[msg.sender] += msg.value;
        totalFunds += msg.value;

        if (totalFunds >= goal) {
            goalReached = true;
        }
    }

    // Function 2: Withdraw funds if goal reached
    function withdraw() external {
        require(msg.sender == owner, "Only owner can withdraw");
        require(goalReached, "Goal not reached yet");
        payable(owner).transfer(address(this).balance);
    }

    // (Optional small helper) Function 3: Get contract balance
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}

