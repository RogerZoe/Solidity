// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract A
 {
    function fun1() public pure returns(string memory)
    {
        return "hello_welcome";
    }
    function fun2() public   pure returns(string memory)
    {
        return "hello_Book";
    }
 }
 contract B 
 {
    uint public X=14;
    function fun3() public   pure returns(string memory)
    {
        return "hello_Book__";
    }
 }
 
 //EXAMPLE FOR MULITPLE INHERITANCE..........................
 contract C is B
 {
        uint public Y;
        constructor()
        {
            Y=42;
            X=123;  // IF THE PROPERTIES ARE SAME IN PARENT AND CHILD ,THEN FIRST IT WILL BE GO TO CHILD AND TO PARENT 
          // IF BOTH VALUES ARE SAME THEN IT WILL CONSIDERED THE FIRST CHILD..............
        }
    function fun4() public  pure returns(string memory)
    {
        return "hello_Book______";
    }
 }
 contract D is B,C      // SHOULD WRITE B,C NOT C,B
 {
           
         
 }
 

// contract A {
//     function foo() public virtual returns (string memory) {
//         return "A";
//     }
// }

// contract B is A {
//     function foo() public virtual override returns (string memory) {
//         return "B";
//     }
// }

// contract C is A {
//     function foo() public virtual override returns (string memory) {
//         return "C";
//     }
// }

// // D inherits from both B and C
// contract D is B, C {
//     // Override the foo function from both B and C
//     function foo() public override(B, C) returns (string memory) {
//         return super.foo(); // Calls the most derived version of foo
//     }
// }
