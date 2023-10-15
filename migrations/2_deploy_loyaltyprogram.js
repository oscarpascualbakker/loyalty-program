const LoyaltyProgram = artifacts.require("LoyaltyProgram");

module.exports = async function(deployer) {
  await deployer.deploy(LoyaltyProgram);
};
