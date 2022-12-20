// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Hello {

    string _myName;
    event Payment (address from, uint amount);

    constructor (string memory name){
        _myName = name;
    }

    function setName (string memory name) public {
        _myName = name;
    }

    function getName() view public returns(string memory ) {
        return _myName;
    }

    function speak() view public returns(string memory ){
		string memory _str =  string.concat("Hello ",_myName);
        return _str;
	}


     function fund() external payable {
         emit Payment (msg.sender, msg.value);

     }
     function getBalance() public view returns(uint) {
         return address(this).balance;
     }
       function withdraw (address payable _to ) external{
        _to.transfer(address(this).balance);
    }
}