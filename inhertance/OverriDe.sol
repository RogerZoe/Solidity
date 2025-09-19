// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

//  PRACTISE WITH ANOTHER EXAMPLE

contract A {
    uint256 public a;

    constructor() {
        a = 100;
    }

    function funA() public {
        a = 10;
    }

    function fun() public pure virtual returns (string memory) {
        // VIRTUAL TO GIVES PERMISSION TO OVERRIDE
        return "hi I am  A";
    }
}

contract B is A {
    uint256 public b;

    constructor() {
        b = 200;
        a = 50;
    }

    function funB() public {
        b = 20;
    }

    function fun() public pure virtual override returns (string memory) {
        // BBY USING OVERRIDE WE OVERRRIDE THE FUNCTION............
        return "hi I am  B";
    }
}

contract C is B {
    uint256 public c;

    constructor() {
        c = 300;
        b = 60;
    }

    function funC() public {
        c = 30;
    }

    function fun() public pure virtual override returns (string memory) {
        return "hi I am  C";
    }
}

contract D is A, B, C {
    // uint public d;

    // constructor() {
    //     c = 300 ;
    //     b = 60;

    // }

    // function funC() public {
    //     c = 30;
    // }

    function fun()
        public
        pure
        virtual
        override(
            /* BY WRITNIG  THIS ==> RIGHT WORD WE CAN TELL THAT */
            A,
            B,
            C
        )
        returns (string memory)
    {
        return "hi I am  D";
    }
}
