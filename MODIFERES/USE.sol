// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract hlo
{
         int public  age;
     modifier Samecode()
     {
        for(int i=0;i<5;i++)
        {
            age=age+i; 
        }
        _;
     }


    function fun( ) public    Samecode returns(int,string memory) 
    {
        return(age,"hello");
    }
    function fun2( ) public   Samecode returns(int,string memory) 
    {
        
        return(age,"hello");
    }
    function fun3( ) public   Samecode returns(int,string memory) 
    {
        
        return(age,"hello");
    }
}