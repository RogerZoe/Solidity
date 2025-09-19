// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Define an interface named `Calculator` with two functions: `Sum` and `Mul`.
// These functions must be implemented by any contract that uses this interface.
interface Calculator {
    function Sum(uint256 _num) external returns (uint256);

    function Mul(uint256 _num) external returns (uint256);
}

// `Hello` contract implements the `Calculator` interface and provides
// specific implementations for the `Sum` and `Mul` functions.
contract Hello is Calculator {
    // The `Sum` function increases the input `_Num` by 100 and returns the result.
    function Sum(uint256 _Num) external pure override returns (uint256) {
        _Num += 100;
        return _Num;
    }

    // The `Mul` function multiplies the input `_Num` by 10 and returns the result.
    function Mul(uint256 _Num) external pure override returns (uint256) {
        _Num *= 10;
        return _Num;
    }
}

// `calci` contract interacts with any contract implementing the `Calculator` interface.
// It stores a reference to a `Calculator` contract and allows the user to call `Sum` and `Mul`.
contract calci {
    // `Out` is a public variable of type `Calculator` that holds a reference
    // to a contract implementing the `Calculator` interface.
    Calculator public Out;

    // `Num` is a public variable that will store the result of the calculations.
    uint256 public Num = 10;

    // Constructor function that sets the `Out` variable to the address of a contract
    // that implements the `Calculator` interface. This address is provided during deployment.
    constructor(address _calculatorAddress) {
        Out = Calculator(_calculatorAddress);
    }

    // The `Sum` function calls the `Sum` function of the `Calculator` contract
    // stored in `Out`, adds its result to `Num`, and returns the updated `Num`.
    function Sum()  public returns (uint256) {
        Num = Out.Sum(Num);
        return Num;
    }

    // The `Mul` function calls the `Mul` function of the `Calculator` contract
    // stored in `Out`, multiplies `Num` by the result, and returns the updated `Num`.
    function Mul() external returns (uint256) {
        Num = Out.Mul(Num);
        return Num;
    }
}

// 1.Deploy the Hello contract first. After deployment, you'll get its contract address.
// 2. Deploy the calci contract by passing the address of the Hello contract as an argument to the constructor.
