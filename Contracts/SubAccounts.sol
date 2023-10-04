//SPDX-License-Identifier:UNLICENSE
pragma solidity 0.8.19;

contract SubAccounts{

    mapping(address => uint256[]) public AddressSubAccounts;
    mapping(uint256 => address) public SubAccountOwner;


}

contract SubAccount{
    address public SubAccountOwner;
    uint256 public SubAccountID;

    constructor(address _owner, uint256 _SubAccountID){
        SubAccountOwner = _owner;
        SubAccountID = _SubAccountID;
    }

    function 

    receive() external payable{
    }
}