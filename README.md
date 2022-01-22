# Preservation

Difficulty 8/10

This contract utilizes a library to store two different times for two different timezones. The constructor creates two instances of the library for each time to be stored.

The goal of this level is for you to claim ownership of the instance you are given.

Things that might help

Look into Solidity's documentation on the delegatecall low level function, how it works, how it can be used to delegate operations to on-chain. libraries, and what implications it has on execution scope.
Understanding what it means for delegatecall to be context-preserving.
Understanding how storage variables are stored and accessed.
Understanding how casting works between different data types.

# Solution

While messing around with the `setSecondTime` function I figured out that this function will update the timeZone1Library address. timeZone1Library is used as the contract address of reference for `setFirstTime`function.
The `setFirstTime` has a `delegatecall` function that will call a function called `setTime`.

Things I did:

- Create a contract that will have at least as many storage as the Preservation Contract
- call the `setSecondTime` with my attacker contract address (`preservationContract.setSecondTime(uint(this))`)
- call the `setFirstTime` function which will call the `setTime` function of my attacker contract
- 3rd slot of the Preservation contract will be updated with `tx.origin` (me)

# Moral

As the previous level, delegate mentions, the use of delegatecall to call libraries can be risky. This is particularly true for contract libraries that have their own state. This example demonstrates why the library keyword should be used for building libraries, as it prevents the libraries from storing and accessing state variables.
