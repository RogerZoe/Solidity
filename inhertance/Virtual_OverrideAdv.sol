// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;
 contract A
 {
    function fun1() public pure returns(string memory)
    {
        return "hello_welcome";
    }
    function fun2() public  virtual pure returns(string memory)
    {
        return "hello_Book";
    }
 }
 contract B is A
 {
    function fun2() public virtual  override pure returns(string memory)
    {
        return "hello_Book__";
    }
 }
 //IF BELOW CONTRACT INHERIT THE CONTRACT B ,THEN USE VIRTUAL IN CONTRACT B
 // WE CAN WRITE BOTH KEYWORDS 
 contract C is B
 {
    function fun2() public override pure returns(string memory)
    {
        return "hello_Book______";
    }
 }