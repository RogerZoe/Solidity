// SPDX-License-Identifier: MIT

 pragma solidity ^0.8.0;
 
  //Enums are useful for situations where you have a fixed set of options or states, like different types of coffee in a coffee shop, 
  //as it helps improve code readability and maintainability by giving meaningful names to these options.

contract MyContract {
       // Enum for different types of coffee
    enum CoffeeType {
        Espresso,
        Latte,
        Cappuccino,
        Americano
    }

    CoffeeType s1;
    CoffeeType[] s2;

    function Get() public view   returns(CoffeeType)
    {
        // return s1.cancel;       // this tries to return s1.cancel as if it were an integer, but cancel is an enum value, not a numerical value
              return s1;
    }

    function Check(CoffeeType _type) pure public returns(string memory)
    {
        if(_type==CoffeeType.Espresso)
        {
            return "Espresso placed";
        }
        else if(_type==CoffeeType.Latte)
        {
            return "Latte placed";
        }
        else if(_type==CoffeeType.Americano)
        {
            return "Americano placed";
        }
         
         revert("Out of Stock");
    }
    function Check1(CoffeeType _type) public 
    {
        s1 = _type;   //
    } 

}