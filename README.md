# Loyalty Program Smart Contract

[![Solidity v0.8.18](https://img.shields.io/badge/Solidity-v0.8.18-blue.svg)](https://soliditylang.org/) [![Ganache](https://img.shields.io/badge/Ganache-CLI-orange.svg)](https://www.trufflesuite.com/ganache) [![Truffle](https://img.shields.io/badge/Truffle-v5.11.4-green.svg)](https://www.trufflesuite.com/truffle)

## Overview

This smart contract is designed to manage a loyalty program. Users can earn and spend points, and the contract owner can define new rewards. It is built using Solidity and can be tested using Ganache and Truffle.

## Variables & Mappings

- `owner`: The address of the contract owner. Only the owner can add new rewards and assign points.
- `points`: A mapping from addresses to points. It stores the points for each user.
- `rewards`: A mapping from reward IDs to descriptions. Rewards that users can redeem are stored here.
- `nextRewardId`: A counter indicating the next available ID for a new reward.

## Events

- `PointsEarned`: Emitted when a user earns points.
- `PointsRedeemed`: Emitted when a user spends points to redeem a reward.
- `NewRewardAdded`: Emitted when a new reward is added to the program.

## Modifiers

- `onlyOwner`: This modifier ensures that only the owner can execute certain functions.

## Functions

1. **Constructor**: On contract deployment, the constructor sets the owner as the address that deployed the contract and initializes `nextRewardId` to 1.

2. **setOwner**: Changes the contract owner's address. Only the current owner can execute this.

3. **addReward**: Allows the owner to add a new reward to the program. This also increments `nextRewardId`.

4. **earnPoints**: Allows the owner to assign points to a specific user address.

5. **redeemPoints**: Any user can redeem points for a specific reward as long as they have enough points.

6. **getPoints**: Returns the number of points a user has.

7. **getReward**: Returns the description of a reward given its ID.

## End-to-End Flow

1. **Deployment**: The owner deploys the contract. They become the owner and `nextRewardId` is initialized to 1.

2. **Reward Setup**: The owner adds several rewards using `addReward`. For example, "Discount Coupon", "Free Item", etc.

3. **Point Accumulation**: The owner assigns points to users using `earnPoints`. This could be in response to some user actions like making a purchase.

4. **Point Checking**: Users can check their point balance at any time using `getPoints`.

5. **Reward Redemption**: Users redeem their points for rewards using `redeemPoints`. Their point balance is decremented and the redemption is logged.

6. **Reward Checking**: Users or the owner can view the available rewards using `getReward`.

7. **Ownership Transfer**: If needed, the original owner can transfer ownership of the contract to another address using `setOwner`.


## Testing & Static Code Analysis

For testing and static code analysis, you can use Truffle, Ganache, and Slither:

```bash
# Compile the contract
truffle compile --all

# Run tests
truffle test
```

For static code analysis, you can use Slither:

```bash
# Run Slither in the project directory
slither .
```

This should provide a detailed assessment of code quality and potential vulnerabilities.


## Disclaimer

This contract is a basic example and should be thoroughly tested and reviewed before being used in a production environment.

## License

[MIT](https://opensource.org/licenses/MIT)

Feel free to save this README.md file and use it as needed. It includes the badges for Solidity, Ganache, and Truffle, along with a detailed explanation of the contract.