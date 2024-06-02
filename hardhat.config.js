require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({path: ".env"});

/** @type import('hardhat/config').HardhatUserConfig */

module.exports = {
  solidity: "0.8.24",


  networks: {
    sepolia: {
        url: process.env.RPC_URL,
        accounts: [process.env.PRIVATE_KEY],
        chainId: 11155111,
    },

  },

  sourcify: {
    enabled: true
  },

  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
};
