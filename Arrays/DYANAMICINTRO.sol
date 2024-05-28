// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Beginning
{


    uint[] public arr; // DYNAMIC ARRAY IS NOT CREATED IN FUNCTION......
    string[] public str=["add",'a','a'];
    uint[] public zrr=[12,3,4,2,2];

    // arr.push(2); // ERROR ,NOT GIVE OUTSIDE THE FUNCTION......

       constructor() {
        arr = new uint[](10); // Initialize with a certain length, e.g., 10
    }

    function get() public 
    {
      
       arr[1]=12;
       arr[2]=14;          // creation
       arr[6]=142;
       arr[3]=121;
    }
    function get2() public 
    {
        arr[4]=22;      //update
        zrr[4]=656;
    }
}