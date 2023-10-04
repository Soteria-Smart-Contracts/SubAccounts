//SPDX-License-Identifier:UNLICENSE
pragma solidity 0.8.19;

contract SubAccounts{
    uint256 public SubIDIncrement;

    mapping(address => uint256[]) public AddressSubAccounts;
    //for each address, internally store a list of index positions of the subaccounts array so that we can replace the subaccount address with the last subaccount address in the array and then delete the last subaccount address in the array
    mapping(address => mapping(uint256 => uint256)) public AddressSubAccountsIndex;


    mapping(uint256 => address) public SubAccountOwner;
    mapping(uint256 => address) public SubAccountAddress;

    event SubAccountCreated(address indexed _owner, uint256 indexed _SubAccountID);
    
    constructor(){
        SubIDIncrement = 1;
    }

    function CreateSubAccount() public returns(uint256 SubAccountID, string memory Nickname) {
        uint256 NewSubAccountID = SubIDIncrement;
        SubIDIncrement++;

        address NewSubAccountAddress = address(new SubAccount(msg.sender, Nickname, NewSubAccountID));
        SubAccountAddress[NewSubAccountID] = NewSubAccountAddress;
        SubAccountOwner[NewSubAccountID] = msg.sender;
        AddRemoveSubAccount(NewSubAccountID, true);

        emit SubAccountCreated(msg.sender, SubIDIncrement);
        return (NewSubAccountID, Nickname);
    }

    //Createsub account with ether deposit
    function CreateSubAccountWithEther() public payable returns(uint256 SubAccountID, string memory Nickname){
        uint256 NewSubAccountID = SubIDIncrement;
        SubIDIncrement++;

        address NewSubAccountAddress = address(new SubAccount(msg.sender, Nickname, NewSubAccountID));
        SubAccountAddress[NewSubAccountID] = NewSubAccountAddress;
        SubAccountOwner[NewSubAccountID] = msg.sender;
        AddRemoveSubAccount(NewSubAccountID, true);

        payable(NewSubAccountAddress).transfer(msg.value);

        emit SubAccountCreated(msg.sender, SubIDIncrement);
        return (NewSubAccountID, Nickname);
    }

    //Internal function
    
    function AddRemoveSubAccount(uint256 ID, bool Addremove) internal {
        if(Addremove){
            AddressSubAccounts[msg.sender].push(ID);
            AddressSubAccountsIndex[msg.sender][ID] = AddressSubAccounts[msg.sender].length - 1;

        }
        else{
            AddressSubAccounts[msg.sender][AddressSubAccountsIndex[msg.sender][ID]] = AddressSubAccounts[msg.sender][AddressSubAccounts[msg.sender].length - 1];
            AddressSubAccounts[msg.sender].pop();
            AddressSubAccountsIndex[msg.sender][ID] = 0;
        }
    }



}

contract SubAccount{
    address public SubAccountOwner;
    string public SubAccountNickname;
    uint256 public SubAccountID;

    constructor(address _owner, string memory Nickname, uint256 _SubAccountID){
        SubAccountOwner = _owner;
        SubAccountID = _SubAccountID;
        SubAccountNickname = Nickname;
    }

    function DepositERC20(address _token, uint256 _amount) external{
        require(msg.sender == SubAccountOwner, "Only SubAccount Owner can deposit");
        ERC20(_token).transferFrom(msg.sender, address(this), _amount);
    }

    function WithdrawERC20(address _token, uint256 _amount) external{
        require(msg.sender == SubAccountOwner, "Only SubAccount Owner can withdraw");
        ERC20(_token).transfer(msg.sender, _amount);
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