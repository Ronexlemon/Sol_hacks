// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./contractA.sol";

import "@openzeppelin/contracts/proxy/Clones.sol";


contract ContractFactory is ContractA{
  using Clones for address;
  address immutable public Implementation;

    event ContractCreated(address indexed newAddr, string name);

    constructor(){
      Implementation = address(new ContractA());
    }

    function createPool()external returns(address _pool) {
       
        address newPool= Implementation.clone();
        ContractA(newPool).register(10, "Lemonr");
        emit ContractCreated(address( newPool), "newPool");
      return address (newPool);

        
    }




}