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

    CoffeeType[] public s2;  // s. These arrays are initialized with and intended to store values from a specific enum type. 
    // They are particularly useful when you want to represent a collection of options or states that are predefined by the enum.
    
    
    //ENUM TO ARRAY..........
    function Get(uint _i) view public returns(uint)
    {
        return uint(s2[_i]);        // IF YOU WRITE LIKE ==> RETURN S2[_I]; ERROR TYPE CONVERSION
    }

     // SO HERE THERE IS NO values being inside the enum array .........
    // CoffeeType[] public s2;
     

     // so , WE PUSH THE VALUES  INTO THE ENUM ARRAY........
     // USE CONSTRUCOTR......

     constructor ()
     {
        s2.push(CoffeeType.Espresso);
        s2.push(CoffeeType.Latte);
        s2.push(CoffeeType.Cappuccino);
        s2.push(CoffeeType.Americano);
     }
}