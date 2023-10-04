//SPDX-License-Identifier:UNLICENSE
pragma solidity 0.8.19;

contract SubAccounts{
    mapping(address => uint256[]) public AddressSubAccounts;
    mapping(uint256 => address) public SubAccountOwner;

    struct SubAccount{
        uint256 ID;
        string NickName;
        uint256 balance;
    }
}