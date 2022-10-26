// SPDX-License-Identifier: SEE LICENSE IN LICENSE

pragma solidity ^0.8.7;

interface tokenRecipient {
  function tokenApproval(
    address _from,
    uint256 _value,
    address _token,
    bytes calldata _extraData
  ) external;
}
