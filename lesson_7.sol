//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
import "https://github.com/bokkypoobah/BokkyPooBahsDateTimeLibrary/blob/master/contracts/BokkyPooBahsDateTimeLibrary.sol";
contract BirthdayPayout {
  
 
 struct TeamMates {
     address acount;
     string name;
     uint256 salary;
     uint256 birthday;
     bool gotMoney;
 }
 
 string _name;
 address _owner;

 TeamMates[] public _teammate;
 constructor (){
     _owner = msg.sender;
     _name = "Yurii";
 }
 modifier OnlyOwner (){
     require (msg.sender == _owner, "should be the owner");
     _;
 }
event NewTeammate(address acount, string name );
event HappyBirthday (string name, address acount);
event NoBirthdayFound (uint256 timestand);

  function addTeammate(address acount, string memory name, uint256 salary, uint256 birthday ) public OnlyOwner{
      require (msg.sender != acount, "cannot be added the owner");
      TeamMates memory newTeammate = TeamMates(acount, name, salary, birthday, false);
      _teammate.push(newTeammate);
      emit NewTeammate (acount , name );
  }

  function getTeamate() view public returns (TeamMates[] memory){
      return _teammate;
  }

function isBirthday(uint256 index) view public returns(bool){
    uint256 birthday = _teammate[index].birthday;
   uint256 today = block.timestamp;
    return _compareDate(birthday, today);
}
function _compareDate(uint256 date_1, uint256 date_2) pure internal returns(bool){
    (, uint256 date_1_month, uint256 date_1_day) = BokkyPooBahsDateTimeLibrary.timestampToDate(date_1);
    (, uint256 date_2_month, uint256 date_2_day) = BokkyPooBahsDateTimeLibrary.timestampToDate(date_2);
    if(date_1_day==date_2_day && date_2_month==date_1_month){
        return true;}
        else{return false;}
    }


function sendToTeammate(uint256 index) public OnlyOwner{
    payable(_teammate[index].acount).transfer(_teammate[index].salary);
}
function deposit() public payable{}
function getDate(uint256 timestamp) pure public returns (uint256 year, uint256 month, uint256 day){
    (year, month, day) = BokkyPooBahsDateTimeLibrary.timestampToDate(timestamp);
}

  function BirthdayPay() public  OnlyOwner {
      bool isBirth;
      require (_teammate.length > 0, "No teammate in the database");
     for(uint256 i=0;i<_teammate.length;i++){
          if(isBirthday(i) && (_teammate[i].gotMoney == false)){
             isBirth = true;
             _teammate[i].gotMoney = true;
             sendToTeammate(i);
             emit HappyBirthday (_teammate[i].name, _teammate[i].acount);
              }
             
            }
            if (isBirth == false) {
                emit NoBirthdayFound (block.timestamp);
                revert ("none found");
            }
          
           
  }


}