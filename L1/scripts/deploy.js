const hre = require("hardhat");

async function main() {

  const [owner, otherAccount] = await hre.ethers.getSigners();
  const l2ContractAddress = "0x0";
  const starknetCore = "0xde29d060D45901Fb19ED6C6e959EB22d8626708e";


  const L1DataBridge = await hre.ethers.getContractFactory("L1DataBridge");
  const bridge = await L1DataBridge.connect(owner).deploy(
    starknetCore, 
    l2ContractAddress
  )

  await bridge.deployed();

  console.log(
    `✨ Deployed L1DataBridge contract to ${bridge.address}`
  );
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
