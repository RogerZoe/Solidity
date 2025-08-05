// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Struct {
    // CREATING STRUCT DATA TYPE;
    struct Person {
        string name;
        uint256 no;
        address route;
    }
    Person public p1; // DECLARING ;    // FOR ONE PERSON..................
    Person[] public p2; // declaring ;   // FOR A GROUP OF PERSONS.....

    function setvalues() public {
        // !.intialize method
        p1.name = "Arif";
        p1.no = 56;
        p1.route = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

        //2.method
        Person memory p3 = Person(
            "arif",
            123,
            0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
        );

        Person memory p4 = Person({
            name: "shaik",
            no: 123,
            route: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
        });

        // 3.method;

        Person memory p5;
        p5.name = "NDCL";
        p5.no = 8;
        p5.route = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
        p2.push(p1);
        p2.push(p3);
        p2.push(p4);
    }
}
