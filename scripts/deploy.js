const {ethers} = require ("hardhat");
require ("dotenv").config({path: ".env"})
console.log(process.env)



async function main() {

    const contractInstance = await hre.ethers.deployContract("GNaira");
    await contractInstance.waitForDeployment();
    const contractAddress = contractInstance.target;

    console.log(`GNaira Token is deployed at ${contractAddress}`)
    console.log('This contract will now be verified on Etherscan and Sourcify using the Contract Address', contractAddress)
    console.log('...Now verifying...')

    const contractVerification = await hre.run("verify:verify", { address: contractAddress});
    
    console.log(contractVerification)
}

main().catch((error) => {console.error(error);
    process.exitCode = 1;

});