// SPDX-License-Identifier: MIT

 // ==> PURPOSE  OF INDICATING THAT UNDER WHICH LICENSE NUMBER THE CODE IS RELEASED  

  // VISISBILITY ==> TELLS US WHO CAN CALL/ACCESS THE STATE VARIABLES AND FUNCTIONS 

  // An external function is a function that can only be called by a third party. 
  // With the external function visibility, a contract that can call the function must be independent of the main contract and can not be a derived contract.

 pragma solidity ^0.8.0;

 // STATE VRAIBALE IS NOT FOR EXTERNAL..

contract check1 {
    uint hlo = 12;

    function get() external view returns (uint) {
        return hlo;
    }
}

contract check3 {
    // Create an instance of check1
    check1 public instanceOfCheck1;

    // Pass the address of check1 to the constructor
    constructor(address _check1Address) {
        instanceOfCheck1 = check1(_check1Address);
    }

    function get2() external view returns (uint) {
        // Call the get function from check1 through the instance
        return instanceOfCheck1.get();
    }
}
