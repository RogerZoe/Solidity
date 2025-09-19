
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PrimeNumbers {
    function findNextPrime(uint256 n) public pure returns (uint256) {
        n++;
        while (!isPrime(n)) {
            n++;
        }
        return n;
    }

    function isPrime(uint256 num) internal pure returns (bool) {
        if (num <= 1) {
            return false;
        }
        for (uint256 i = 2; i <= sqrt(num); i++) {
            if (num % i == 0) {
                return false;
            }
        }
        return true;
    }

    function sqrt(uint256 x) internal pure returns (uint256 y) {
        
        // EFFICIENT ONE 
        uint256 z = (x + 1) / 2;
        y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }

        for(uint i=0;i<x/2;i++)
        {
            uint ans=i*i;
            if(ans>10)
            {
                return i-1;
            }
        }
    }
}

