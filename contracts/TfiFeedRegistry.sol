// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract TfiFeedRegistry is Initializable, OwnableUpgradeable {
  struct RoundData {
    int256 answer;
    uint256 startedAt;
    uint256 updatedAt;
  }
  uint80 public latestRound;
  mapping (string => mapping(uint80 => RoundData)) private data;

  function initialize(
  ) public initializer {
    __Ownable_init();
  }

  function getRoundData(string memory key, uint80 roundId)
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
    RoundData memory rd = data[key][roundId];
    return (roundId, rd.answer, rd.startedAt, rd.updatedAt, latestRound);
  }

  function latestRoundData(string memory key)
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
    string memory key,
    uint80 roundId,
    int256 answer,
    uint256 startedAt,
    uint256 updatedAt
  )
  external
  virtual
  {
    latestRound = roundId;
    data[key][roundId] = RoundData(answer, startedAt, updatedAt);
  }

}
