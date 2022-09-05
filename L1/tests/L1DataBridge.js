const {
    time,
    loadFixture,
  } = require("@nomicfoundation/hardhat-network-helpers");
  const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
  const { expect } = require("chai");
  
  describe("L1DataBridge", function () {
    async function deployL1DataBridgeFixture() {
  
      const [owner, otherAccount] = await ethers.getSigners();
      const L1DataBridge = await ethers.getContractFactory("L1DataBridge");
      const l2ContractAddress = "0x0";
      const starknetCore = "0xde29d060D45901Fb19ED6C6e959EB22d8626708e";
      const bridge = await L1DataBridge.connect(owner).deploy(
        starknetCore, 
        l2ContractAddress
      )
  
      return { bridge, l2ContractAddress, owner, otherAccount };
    }
  
    describe("Deployment", function () {
      it("Should set the right contract address", async function () {
        const { bridge, l2ContractAddress } = await loadFixture(deployL1DataBridgeFixture);
        expect(await bridge.l2_contract()).to.equal(l2ContractAddress);
      });
  
      it("Should set the right owner", async function () {
        const { bridge, owner } = await loadFixture(deployL1DataBridgeFixture);
  
        expect(await bridge.owner()).to.equal(owner.address);
      });
  
    });

  });
  