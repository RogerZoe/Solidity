// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

 //  MODIFIERS CAN CHANGE THE FUNCTION BEHAVIOUR 
contract Hlo
{
     
     // MODIFER WITH ARGUMENTS...............
      uint public num=12;
  
        modifier Col(uint _num)
        {
            require(_num<20,"fuck off");
            _;
        }
        function Get(uint _num)   public Col(_num) 
        {
      num=_num;
        }
    
}

contract Sec
{

      // MODIFIER WITHOUT ARGUMENT...........
      uint public num=12;
  
        modifier Col
        {
            require(num<10,"fuck off");
            _;
        }
        function Get(uint _num)   public Col 
        {
      num=_num;
        }
}

contract Both
{
    // MULTIPLE MODIFIERS............


    struct Student
    {
        uint no;
        string name ;
        uint age;
    }

    Student s1;
    

    modifier Check(uint _age)
    {
        require(_age<10,"fuck off");
        _;
    }
    modifier  Check2(uint _no)
     {
         require(_no<5,"check the condition");
         _;
    }

    function Get(uint no,string memory name,uint age) public Check(5) Check2(2)
    {
         s1.age=age;
         s1.name=name;
         s1.no=no;

    }
}
