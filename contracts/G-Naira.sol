// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract GNaira is ERC20 {

/* Blacklisting accounts means the blacklisted account cannot send or receive tokens 

*/
mapping (address => bool) private _blacklisted; //A mapping to store the blacklisted addresses 
event Blacklisted(address indexed account); //Emits the blacklisted accounts 
event UnBlacklisted(address indexed account); //Emits the unblacklisted accounts



    address public owner; //This is the account of the contract deployer, which is also the account of the Governor which will be used in the onlyGovernor modifier

    modifier onlyGovernor(){ //this modifier will be used where the function is to be done only by the Governor
        require (msg.sender == owner,"Only the Governor can call this function");
        _;
    }


    constructor() 
    ERC20("GNaira", "gNGN") {
        owner = msg.sender;       
    }

     modifier notBlacklisted(address account) { //This modifier is used when the function it is used in has to check if the required address is blacklisted or not
        require(!_blacklisted[account], "This Address is blacklisted");
        _;

     }

    function mint(address to, uint256 amount) public onlyGovernor {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public onlyGovernor{
        _burn(from, amount);
    }

      function addBlacklist(address account) external onlyGovernor {
        _blacklisted[account] = true;
        emit Blacklisted(account);
    }

    function removeBlacklist(address account) external onlyGovernor {
        _blacklisted[account] = false;
        emit UnBlacklisted(account);
    }

    function isBlacklisted(address account) external view returns (bool) {
        return _blacklisted[account];
    }

    function transfer(address recipient, uint256 amount) public override notBlacklisted(_msgSender()) notBlacklisted(recipient) returns (bool) {
        return super.transfer(recipient, amount);
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override notBlacklisted(sender) notBlacklisted(recipient) returns (bool) {
        return super.transferFrom(sender, recipient, amount);
    }

}