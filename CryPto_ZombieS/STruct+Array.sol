 // SPDX-License-Identifier: MIT

 // ==> PURPOSE  OF INDICATING THAT UNDER WHICH LICENSE NUMBER THE CODE IS RELEASED  

 pragma solidity ^0.8.0;

 contract Helo
 {
    struct person{
        uint age;
        string name;
        address add;
    }
    person[] public people;  // ARRAYS OF STRUCTS...........
    
    function Get(uint _age,string memory _name,address _add) public  
    {
             //CREATING PERSONS.

            //  person memory p1 =person(12,"Arif",0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
            
             person memory p2=person(_age,_name,_add);
            
            // ADD TO THAT ARRAY...........
             people.push(p2);
           
            // IN ONE LINE............
             people.push(person(_age,_name,_add));

    }

 }