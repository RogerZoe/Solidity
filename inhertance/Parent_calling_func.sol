// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

contract A
{
    event log(string name,uint age);
    function fun1() public  virtual
    {
        emit log("fun1",120);
    }
    function fun2() public virtual{
        emit log("fun2",21);
    }
}

 /// FOR SIMPLE INHERITANCE HOW SUPER KEYWORD BEHAVES ..............
contract B is A
{

    function fun1() public virtual override
    {
        emit log("B.fun1",112);
        A.fun1(); // DIRECT CALLING..............
    }
    function fun2() public virtual override{
        emit log("B.fun2",201);
        super.fun2();  // RIGHT MOST INHERITED  CONTRACT ..............
    }
}

// FOR MULTIPLE INHERITANCE 

contract C is A,B
{
    function fun1() public  override(A,B)
    {
        emit log("C.fun1",12);
        B.fun1();        //     ==> IT GIVES "C.FUN1" AND 12,"B.FUN1" AND 112 ,"FUN1' AND 120.
    }
    function fun2() public override(A,B) {
        emit log("C.fun2",121);
        super.fun2();         // ==> IF WE REMOVE SUPER IN B ,THEN IT GIVES B'S OUTPUT  AND "C.FUN1" AND 121
    }
}