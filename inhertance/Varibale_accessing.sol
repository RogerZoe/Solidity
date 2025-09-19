 // SPDX-License-Identifier: MIT

 // ==> PURPOSE  OF INDICATING THAT UNDER WHICH LICENSE NUMBER THE CODE IS RELEASED  

 pragma solidity ^0.8.0;


contract ONE {
    uint sex=123;
    function fuN() public pure returns (string memory) {
        return "hello k";
    }


// ONE  WAY TO ACCESS THE LOCAL VARIABLES................
    function fun2() public pure returns (string memory, uint) {
        uint Num = 32;
        return ("name of the pornstar", Num);
    }

    //SECOND WAY................
    function fun() public pure returns ( uint) {
        uint Num2 = 32;
        return (Num2);
    }


}

contract two is ONE {
    ONE p1 = new ONE();

      // ONE WAY.................
    function funTwo() public view returns (string memory, uint) {
        
        return p1.fun2();
    }

    // SECOND WAY................
      function getNum() public view returns (uint) {
        return p1.fun();
    }
    

     // RETURNING THE STATE VARIABLE...............
    function ret() public  view returns(uint)
    {
        return sex;
    }
}