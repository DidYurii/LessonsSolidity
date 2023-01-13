//SPDX-License-Identifier:MIT
pragma solidity ^0.8.17;

interface ILiving{
    function eat(string memory food) view external  returns(string memory);
    function speak() view external returns(string memory);
    function sleep() pure external returns(string memory);
}

library StringComparer{
    function compare(string memory str1, string memory str2) public pure returns (bool) {
        return keccak256(abi.encodePacked(str1)) == keccak256(abi.encodePacked(str2));
    }
}
 abstract contract Animal is ILiving {
       
    function eat(string memory food) view virtual  public returns(string memory){
    return string.concat("Animal eats ", food);
}
      function sleep() pure public returns(string memory){
        return "Z-z-z...";
    }

    
}

contract HasName{
    string internal _name;
    constructor(string memory name){
        _name=name;
    }

    function getName() view public returns(string memory){
        return _name;
    }
}

 abstract contract PlantEater is Animal{
    string constant PLANT = "plant";

    modifier eatOnlyPlant(string memory food){
        require(StringComparer.compare(food,PLANT),"Can only eat plant food");
        _;
    }
     
    function eat(string memory food)  view override virtual  public eatOnlyPlant(food) returns(string memory){
        return super.eat(food);
    }
}

abstract contract MeatEater is Animal {
string constant MEAT = "meat";

modifier eatOnlyMeat(string memory food){
    require(StringComparer.compare(food, MEAT), "Can only eat meat");
    _;
}
function eat(string memory food)  view override virtual  public eatOnlyMeat(food) returns(string memory){
        return super.eat(food);
    }
}

contract Cow is PlantEater, HasName{

    constructor(string memory name) HasName(name){
    }

    function speak() pure override public returns(string memory){
        return "Mooo";
    }
}

contract Horse is PlantEater, HasName{

    constructor(string memory name) HasName(name){
    }

    function speak() pure override public returns(string memory){
        return "Igogo";
    }

}

contract Wolf is MeatEater{

    function speak() pure override public returns(string memory){
        return "Awooo";
    }
}

contract Dog is MeatEater, PlantEater, HasName {
    constructor(string memory name) HasName(name){
    }
     function eat(string memory food) view override(PlantEater, MeatEater)   public returns (string memory){
         require (!StringComparer.compare(food,"chocolate"), "chocolate is harmful for dog");
       return super.eat(food);
    }
    function speak() pure override public returns (string memory){
        return "Woof";
    }
}

contract Farmer{
    function feed(address animal, string memory food) view public returns(string memory){
        return ILiving(animal).eat(food);
    }

    function call(address animal) view public  returns(string memory){
        return ILiving(animal).speak();
    }
}