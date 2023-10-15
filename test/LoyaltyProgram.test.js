const LoyaltyProgram = artifacts.require("LoyaltyProgram");
const truffleAssert = require('truffle-assertions');
const { expect } = require('chai');

contract("LoyaltyProgram", (accounts) => {
    let contract;
    const [owner, user1] = accounts;


    beforeEach(async () => {
        contract = await LoyaltyProgram.new({ from: owner });
    });


    describe("Ownership", () => {
        it("should set the owner during construction", async () => {
            expect(await contract.owner()).to.equal(owner);
        });

        it("should allow owner to transfer ownership", async () => {
            await contract.setOwner(user1, { from: owner });
            expect(await contract.owner()).to.equal(user1);
        });
    });


    describe("Rewards Management", () => {
        it("should allow owner to add a new reward", async () => {
            const tx = await contract.addReward("Free Coffee", { from: owner });
            truffleAssert.eventEmitted(tx, 'NewRewardAdded', (ev) => {
                return ev.rewardId.toString() === "1" && ev.description === "Free Coffee";
            });
        });

        it("should return the correct reward description", async () => {
            const description = "Test Reward";
            await contract.addReward(description, { from: owner });

            const rewardDescription = await contract.getReward(1);

            expect(rewardDescription).to.equal(description);
        });

        it("should return an empty string for an invalid rewardId", async () => {
            const rewardDescription = await contract.getReward(999);

            expect(rewardDescription).to.equal("");
        });
    });


    describe("Point System", () => {
        it("should allow owner to award points", async () => {
            await contract.earnPoints(user1, 10, { from: owner });
            expect((await contract.getPoints(user1)).toString()).to.equal("10");
        });

        it("should allow users to redeem points for existing rewards", async () => {
            await contract.addReward("Free Coffee", { from: owner });
            await contract.earnPoints(user1, 1, { from: owner });

            const tx = await contract.redeemPoints(user1, 1, { from: user1 });

            truffleAssert.eventEmitted(tx, 'PointsRedeemed', (ev) => {
                return ev.user === user1 && ev.rewardId.toString() === "1" && ev.rewardDescription === "Free Coffee";
            });

            expect((await contract.getPoints(user1)).toString()).to.equal("0");
        });
    });

});
