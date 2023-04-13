// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract TfiFeedRegistry is Initializable, OwnableUpgradeable,
AccessControlUpgradeable {
  struct RoundData {
    int256 answer;
    uint256 startedAt;
    uint256 updatedAt;
  }
  uint80 public latestRound;
  mapping (bytes32 => bool) private global;
  mapping (bytes32 => mapping(uint80 => RoundData)) private data;

  function initialize(
  ) public initializer {
    __Ownable_init();
    __AccessControl_init();
  }

  function getRoundData(bytes32 key, uint80 roundId)
  external
  view
  virtual
  returns (
    uint80 roundId_,
    int256 answer,
    uint256 startedAt,
    uint256 updatedAt,
    uint80 answeredInRound
  )
  {
    require(
      global[key] || hasRole(roleId("read", key), msg.sender)
    );
    RoundData memory rd = data[key][roundId];
    return (roundId, rd.answer, rd.startedAt, rd.updatedAt, latestRound);
  }

  function latestRoundData(bytes32 key)
  external
  view
  virtual
  returns (
    uint80 roundId_,
    int256 answer,
    uint256 startedAt,
    uint256 updatedAt,
    uint80 answeredInRound
  )
  {
    return this.getRoundData(key, latestRound);
  }

  function setRoundData(
    bytes32 key,
    uint80 roundId,
    int256 answer,
    uint256 startedAt,
    uint256 updatedAt
  )
  external
  virtual
  {
    require(hasRole(roleId("set", key), msg.sender));
    latestRound = roundId;
    data[key][roundId] = RoundData(answer, startedAt, updatedAt);
  }

  function roleId(
    bytes32 role,
    bytes32 key
  ) public pure returns (bytes32) {
    return keccak256(abi.encodePacked(role, key));
  }

  function setGlobal(
    bytes32 key_,
    bool value_
  ) public {
    global[key_] = value_;
  }
}
