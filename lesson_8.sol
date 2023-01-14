//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Contact{
    string _name;
    
    constructor(string memory name){
        _name = name;
           }

function getName() public view returns (string memory){
   return _name;
}

function reply() public view returns (string memory){
    return string.concat(getName(), " on call!");
}
}

contract ContactBook{
    string _name;
    address _owner;
    event NewContact (string  name, uint256 index);

    constructor(string memory name){
        _name = name;
        _owner = msg.sender;
    }

    
    address[] private _contacts;
    mapping (address => string) private _contactNames;
    uint256 private _numberOfContact;

    function addContact(string memory name) public onlyOwner emitEvent(name) {
        Contact newContact = new Contact(name);
        _contacts.push(address(newContact));
        _contactNames[address(newContact)] = name;
    }

    function callContact(uint index) public view returns(string memory){
        Contact newContact = getContact(index);
        return newContact.reply();
        
    }
     
     function getContact(uint index)view public returns(Contact){
         return Contact(_contacts[index]);
     }

     modifier onlyOwner(){
         require(_owner == msg.sender, "should be the owner");
         _;
     }
     modifier emitEvent(string memory name){
         _;
         emit NewContact(name, _contacts.length);
     }
}