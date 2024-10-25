import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const CrowdFundingModule = buildModule("CrowdfundingModule", (c) => {
  const crowdfunding = c.contract("CrowdFunding");

  return {crowdfunding};
});

export default CrowdFundingModule;