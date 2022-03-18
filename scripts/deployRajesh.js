
const hre = require("hardhat");

async function main() {
  
  let tokenName = "Rajesh";
  let tokenSymbol = "RAJ";
  // We get the Rajesh contract to deploy
  const Rajesh = await hre.ethers.getContractFactory("Rajesh");
  const rajesh = await Rajesh.deploy(tokenName, tokenSymbol);

  await rajesh.deployed();

  console.log("Rajesh NFT deployed to:", rajesh.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
