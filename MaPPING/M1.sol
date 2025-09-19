// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

// Question is IF WE TYPE THE __ADDRESS__ THEN GET ALL THE DETAILS OF THAT ADDRESS WHO ARE DONATING TO " NGO "?

contract m1 {

    // MAPPING ==> ADDRESS TO STRUCT 
    mapping(address=>details) public acc_info;

  // DONATION PERSON DETAILS FILLING FORM

     function set(string memory _name,uint _age,string  memory _place,uint _donate) public 
     {
          // WE ARE SETTING THE DETAILS TO ADDRESS
      
            acc_info[msg.sender]= details(_name,_age,_place,_donate);  //HERE OUTPUT IS SAME FOR EVERY TIME YOU GIVE INPUT

             // IF WE WRITE LIKE THIS THEN DONATION IS ADDED AND SHOW NOW UPDATE VALUE 
            acc_info[msg.sender]= details(_name,_age,_place,acc_info[msg.sender].donate+_donate);
     }
     // function delete_info() public {
     //    delete acc_info[msg.sender];
     // }
}
 // THESE ARE THE DETAILS OF THE STRUCT NEEED TO DISPLAY 
struct details
{  
     string name;
     uint age;
     string place; 
     uint donate;
}
