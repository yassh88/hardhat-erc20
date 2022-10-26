// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.7;
import "hardhat/console.sol";

contract ManualTokens {
  string public name;
  string public symbol;
  uint8 public decimals;
  uint256 public totalSupply;

  mapping(address => uint256) public balanceOf;
  mapping(address => mapping(address => uint256)) public allowance;

  event Transfer(address _from, address _to, uint256 _value);

  event Approval(address _owner, address _spender, uint256 _value);

  event BurnEvent(address _index, uint256 _value);

  constructor(
    uint256 _intialSupply,
    string memory _name,
    string memory _symbol
  ) {
    console.log(_intialSupply);
    console.log(10**uint256(decimals));
    console.log(_intialSupply * 10**uint256(decimals));
    totalSupply = _intialSupply * 10**uint256(decimals);
    name = _name;
    symbol = _symbol;
    balanceOf[msg.sender] = totalSupply;
  }

  function _transfer(
    address _from,
    address _to,
    uint256 _value
  ) internal {
    require(_to != address(0x0));
    require(_value <= balanceOf[_from]);
    require(balanceOf[_to] + _value >= balanceOf[_to]);
    console.log("balanceOf[_to]");
    console.log(balanceOf[_to]);
    console.log(balanceOf[_from]);
    uint256 previousBalances = balanceOf[_from] + balanceOf[_to];
    balanceOf[_from] = balanceOf[_from] - _value;
    balanceOf[_to] = balanceOf[_to] + _value;

    console.log("balanceOf[_to]----");
    console.log(balanceOf[_to]);
    console.log(balanceOf[_from]);
    assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
  }

  function transfer(address _to, uint256 _value) public returns (bool success) {
    _transfer(msg.sender, _to, _value);
    return true;
  }

  function transferFrom(
    address _from,
    address _to,
    uint256 _value
  ) public returns (bool success) {
    console.log("value");
    console.log(_value);
    require(_value <= allowance[_from][msg.sender]);
    allowance[_from][msg.sender] -= _value;
    _transfer(_from, _to, _value);
    return true;
  }

  function approve(address _spender, uint256 _value)
    public
    returns (bool success)
  {
    allowance[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
  }

  function approveAndCall(
    address _spender,
    uint256 _value,
    bytes memory // _extraData
  ) public returns (bool success) {
    if (approve(_spender, _value)) {
      return true;
    }
  }

  function burn(uint256 _value) public returns (bool success) {
    require(balanceOf[msg.sender] >= _value);
    balanceOf[msg.sender] -= _value;
    totalSupply -= _value;
    emit BurnEvent(msg.sender, _value);
    return true;
  }

  function burnFrom(address _from, uint256 _value)
    public
    returns (bool success)
  {
    require(_value < allowance[_from][msg.sender]);
    require(balanceOf[_from] >= _value);
    balanceOf[_from] -= _value;
    allowance[_from][msg.sender] -= _value;
    totalSupply -= _value;
    emit BurnEvent(_from, _value);
    return true;
  }

  function getAllowance(address _owner, address _spender)
    public
    view
    returns (uint256 remaining)
  {
    remaining = allowance[_owner][_spender];
  }

  function getName() public view returns (string memory) {
    return name;
  }

  function getSymbol() public view returns (string memory) {
    return symbol;
  }

  function getDecimals() public view returns (uint8) {
    return decimals;
  }

  function getTotalSupply() public view returns (uint256) {
    return totalSupply;
  }

  function getBalanceOf(address _owner) public view returns (uint256 balance) {
    return balanceOf[_owner];
  }
  //
}
