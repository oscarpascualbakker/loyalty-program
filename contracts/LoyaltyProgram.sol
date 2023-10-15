// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract LoyaltyProgram {

    address public owner;

    // Mapping to store points for each user
    mapping(address => uint256) private points;

    // Mapping to store available rewards
    mapping(uint256 => string) public rewards;

    // ID for the next reward to be added
    uint256 public nextRewardId;


    event PointsEarned(address indexed user, uint256 amount);
    event PointsRedeemed(address indexed user, uint256 rewardId, string rewardDescription);
    event NewRewardAdded(uint256 rewardId, string description);


    // Modifier for functions that only the owner can call
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }


    /**
     * @dev Constructor to initialize the contract.
     * Sets the contract's owner to the deployer.
     */
    constructor() {
        owner = msg.sender;
        nextRewardId = 1;
    }


    /**
     * @dev Allows the owner to change the contract's owner.
     * @param _newOwner The address of the new owner.
     */
    function setOwner(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "New owner address cannot be zero");
        owner = _newOwner;
    }


    /**
     * @dev Allows the owner to add a new reward to the program.
     * @param description The description of the reward.
     */
    function addReward(string memory description) public onlyOwner {
        rewards[nextRewardId] = description;
        emit NewRewardAdded(nextRewardId, description);
        nextRewardId++;
    }


    /**
     * @dev Allows the owner to award points to a user.
     * @param user The address of the user who will receive the points.
     * @param amount The amount of points to award.
     */
    function earnPoints(address user, uint256 amount) public onlyOwner {
        points[user] += amount;
        emit PointsEarned(user, amount);
    }


    /**
     * @dev Allows a user to redeem their points for a reward.
     * @param user The address of the user redeeming the points.
     * @param rewardId The ID of the reward the user wishes to redeem.
     */
    function redeemPoints(address user, uint256 rewardId) public {
        require(points[user] > 0, "Not enough points");
        require(bytes(rewards[rewardId]).length > 0, "Reward does not exist");

        points[user]--;
        emit PointsRedeemed(user, rewardId, rewards[rewardId]);
    }


    /**
     * @dev Query a user's points.
     * @param user The address of the user.
     * @return The amount of points the user has.
     */
    function getPoints(address user) public view returns (uint256) {
        return points[user];
    }


    /**
     * @dev Query a reward's description.
     * @param rewardId The ID of the reward.
     * @return The description of the reward.
     */
    function getReward(uint256 rewardId) public view returns (string memory) {
        return rewards[rewardId];
    }

}
