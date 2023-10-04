//SPDX-License-Identifier:UNLICENSE
pragma solidity 0.8.19;

contract SubAccounts{
    
    mapping(address => uint256[]) public AddressSubAccounts;
    mapping(uint256 => address) public SubAccountOwner;


}

contract SubAccount{
    address public owner;
    uint256 public SubAccountID;

    constructor(address _owner, uint256 _SubAccountID){
        owner = _owner;
        SubAccountID = _SubAccountID;
    }

    function deposit(uint256 _amount) public{
        balance += _amount;
    }
    function withdraw(uint256 _amount) public{
        balance -= _amount;
    }
    function getBalance() public view returns(uint256){
        return balance;
    }
    function getOwner() public view returns(address){
        return owner;
    }
    function getSubAccountID() public view returns(uint256){
        return SubAccountID;
    }
}