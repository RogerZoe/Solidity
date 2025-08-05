// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract first
{
    uint public age;
    string public name;

    constructor(uint _age,string memory  _name)
    {
         age=_age;
         name=_name;
 
    }
}
contract second{
    uint public age1;
    string public name1;
    constructor(uint _age,string memory _name)
    {
        age1=_age;
        name1=_name;
    }
}

//___"contract third is second,first__ " IF WE WRITE LIKE THIS THEN IT GIVES ERROR 
// BECAUSE WITHOUT PROVIDING THE VALUES WE ARE INHERITING THE PRORERTIES OF PARENT............
 
 //ONE OF THE FIXED WAY TO PASS THE PARAMEMTER TO PARENT CONSTRUCTOR.......... 

contract third is first(22,"Arif"), second(12,"Arif")
{

}

// SECOND WAY............

 contract fourth is first,second
 {
    constructor() first(13,"shaik") second(17,"zaheer")
    {

    }
 }
   // THIRD WAY IS DYNAMIC WAY..........

   contract fifth is first,second
   {
    constructor(uint age,string memory name,uint age1,string memory  name1) first(age,name)second(age1,name1)
    {

    }
   }
   // WE CAN MIX THE BOTH FIXED AND DYNAMIC LIKE THIS..........
    contract sixth is first(14,"Shaik"),second
   {
    constructor(uint age1,string memory  name1) second(12,"Arif")
    {

    }
   }