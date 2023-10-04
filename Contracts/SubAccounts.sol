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

    function DepositERC20(address _token, uint256 _amount) external{
        require(msg.sender == SubAccountOwner, "Only SubAccount Owner can deposit");
        ERC20(_token).transferFrom(msg.sender, address(this), _amount);
    }

    receive() external payable{
    }
}

interface ERC20 {
  function balanceOf(address owner) external view returns (uint256);
  function allowance(address owner, address spender) external view returns (uint256);
  function approve(address spender, uint value) external returns (bool);
  function transfer(address to, uint value) external returns (bool);
  function transferFrom(address from, address to, uint256 value) external returns (bool); 
  function totalSupply() external view returns (uint);
} 

interface ERC721{
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
    function ownerOf(uint256 _tokenId) external view returns (address);
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);
}