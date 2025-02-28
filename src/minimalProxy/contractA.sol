// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


contract ContractA{
    address public owner;
    struct Person{
        uint256 age;
        string name;
        address _address;
    }

    uint256 public count;
    mapping(uint256 => Person)public person;
    constructor(){
        owner = msg.sender;
        
    }


    function  register(uint256 _age,string memory name)external {
        person[count] = Person({age:_age,name:name,_address:msg.sender});
        count ++;
    }
    function GetPerson(uint256 _id)external  view returns(Person memory){
        return person[_id];
    }




   
}