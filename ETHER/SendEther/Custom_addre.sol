// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

/// IN THIS ,WE WANT TO SEND CUSTOM ADDRESS LIKE (USER CAN GIVE THAT ADDRESS)........

contract SendETH
{
   

    // address payable public getter=payable(0x17F6AD8Ef982297579C203069C1DbfFE4348c372);
    
    receive() external payable{}

     function checkbal() public view returns (uint)
   {
    return address(this).balance;
    }
      // ADD ADDRESS payable GETTER...........
     function Send(address  payable Getter) public {
               bool sent=Getter.send(2000000000000000000);
               require(sent,"transc Failed");
         }

    function Transfer(address payable Getter) public {
            Getter.transfer(2000000000000000000);
         }

    function Call(address payable Getter) public {
         (bool sent,)  = Getter.call{value:2000000000000000000}("");
         require(sent,"fuck off");
         }

      // HERE IN THIS WHEN DEPLOYING ,WANT TO [press]MAKE THE TRANSACT (I NEED FAST TRANSACTION AT A TIME)...........
           // SO WE USE MSG.VALUE TO TRAFSER SIMULTANOESLY.........FOR THAT MAKE FUNCTION AS PAYABLE....

}

contract  Check{

    // address payable public getter=payable(0x17F6AD8Ef982297579C203069C1DbfFE4348c372);
    
    receive() external payable{}

     function checkbal() public view returns (uint)
   {
    return address(this).balance;
    }
      // ADD ADDRESS payable GETTER...........
     function Send(address  payable Getter) public payable {
               bool sent=Getter.send(msg.value);
               require(sent,"transc Failed");
         }

    function Transfer(address payable Getter) public payable {
            Getter.transfer(msg.value);
         }

    function Call(address payable Getter) public payable{
         (bool sent,)  = Getter.call{value:msg.value}("");
         require(sent,"fuck off");
         }
}