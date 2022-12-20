// SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;

contract ContactStorage{
string private _name;
address private _address;
address private owner;
uint256 public _numberOfContacts;
event NewContact (address acount, string name, uint256 index);
constructor (){
    owner = msg.sender;
    }
modifier onlyOwner() {
require (msg.sender == owner, "should be owner of the contract");
_;
} 
mapping(address => string) private _addressToName;
mapping(string => address) internal _nameToAddress;
address[] _contacts;
function setAddress (address acount) public onlyOwner{
     _address = acount;
 }
 function getAddress() view public returns(address){
     return _address;
 }
function setName(string memory name) public onlyOwner{
    _name = name;
}
function getName()view public returns (string memory){
    return _name;
}
 function getContactNamebyAddress(address  contactAddress) view public returns(string memory){
     return _addressToName[contactAddress];
 }
 
 function getContactName(string memory name)  public view returns(address){
     return _nameToAddress[name];
 }
 function getContactAddressByIndex(uint256 i)  public view returns(address){
     return _contacts[i-1];
 }
 function addContact(address acount, string memory name) public onlyOwner{
     _contacts.push(acount);
     _addressToName[acount] = name;
     _nameToAddress[name] = acount;
          emit NewContact(acount, name, getLastIndex());
     incrementContactNumber(); 
 }
 function incrementContactNumber() internal{
     _numberOfContacts +=1;
 }
 function getLastIndex() view public returns(uint256){
     if (_numberOfContacts > 0){
         return _numberOfContacts-1;
     }
     return _numberOfContacts;
 }

}