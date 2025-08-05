// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;


contract Event
{
    event First (address  _add,string name);
    string Name;
    address add;

    function crt(string memory _name,address  _add) public 
    {
              Name=_name;
              add=_add;
               // EMIT THE TRIGGERED EVENT 
              emit First (add,Name);
    }
    function get() public  view returns(address ,string memory)
    {
              return(add,Name);
    }
    
    
}