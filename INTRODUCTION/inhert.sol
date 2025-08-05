// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract hlo
{
    function fun1() public pure returns(string memory)
    {
        return "hello_welcome";
    }
    function fun2() public pure returns(string memory)
    {
        return "hello_Book";
    }
    function fun3() public pure virtual returns(string memory)           // IF YOU WANT TO CHANGE THIS FUNCTION ,THEN USE VIRTUAL HERE
    {
        return "hello_world";
    }
    function fun4() public pure virtual returns(string memory)
    
    // IF YOU WANT TO CHANGE THIS FUNCTION ,THEN USE VIRTUAL HERE
    {
        return "welcome";
    }
    
}

 // LIKE IF WE WANT TO CHANGE THE CODE ONLY FOR ONLY LAST FUN4() INLUCDING ALL ABOVE FUNCTIONS....
 // WITHOUT INHERITANCE THAN THE DUPLICATION  OF CODE OCCURS 

contract  b is hlo
{
    
    function fun3() public pure override  returns(string memory)
    {
        return "hello_welcome and namste";
    }
    function fun4() public pure override returns(string memory)
    {
        return "hello_Book and LOve";
    }

}