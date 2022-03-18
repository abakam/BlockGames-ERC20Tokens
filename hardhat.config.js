require('@nomiclabs/hardhat-ethers');
require('@nomiclabs/hardhat-etherscan');
const { apiKey, privateKey, etherScanApi } = require('./secrets.json');

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.5",
  networks: {
    rinkeby: {
      url: `https://rinkeby.infura.io/v3/${apiKey}`,
      accounts: [privateKey], 
      gas: 100000000000000
    },
  },
  etherscan: {
    apiKey: etherScanApi
  }
};
