
const hre = require("hardhat");

async function main() {
  
  let tokenName = "Stuffy";
  let tokenSymbol = "STY";
  let totalTokenSupply = 10000000;
  // We get the Stuffy contract to deploy
  const Stuffy = await hre.ethers.getContractFactory("Stuffy");
  const stuffy = await Stuffy.deploy(tokenName, tokenSymbol, totalTokenSupply);

  await stuffy.deployed();

  console.log("Stuffy token deployed to:", stuffy.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
