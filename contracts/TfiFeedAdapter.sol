// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./TfiFeedRegistry.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV2V3Interface.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract TfiFeedAdapter is Initializable, OwnableUpgradeable,
AggregatorV2V3Interface {
  TfiFeedRegistry public registry;
  string public registryKey;

  function initialize(
    TfiFeedRegistry registry_,
    string memory registryKey_
  ) public initializer {
    __Ownable_init();
    registry = registry_;
    registryKey = registryKey_;
  }

  function decimals() external view returns (uint8) {
    return 18;
  }

  function description() external view returns (string memory) {
    return "TfiFeedAdapter";
  }

  function getAnswer(uint256 roundId) external view returns (int256) {
    return roundId;
  }

  /**
   * @notice details for the given aggregator round
   * @param roundId target aggregator round (NOT OCR round). Must fit in uint32
   * @return roundId_ roundId
   * @return answer price of the pair at this round
   * @return startedAt timestamp of when observations were made offchain
   * @return updatedAt timestamp of block in which report from given roundId was transmitted
   * @return answeredInRound roundId
   */
  function getRoundData(uint80 roundId)
    external
    view
    virtual
    override
    returns (
      uint80 roundId_,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    )
  {
    return (roundId, 0, 0, 0, 0);
  }

  function getTimestamp(uint256 roundId) external view returns (uint256) {
    return roundId;
  }

  function latestAnswer() external view returns (int256) {
    return 0;
  }

  function latestRound() external view returns (uint256) {
    return 0;
  }


  /**
   * @notice aggregator details for the most recently transmitted report
   * @return roundId aggregator round of latest report (NOT OCR round)
   * @return answer price of the pair at this round
   * @return startedAt timestamp of when observations were made offchain
   * @return updatedAt timestamp of block containing latest report
   * @return answeredInRound aggregator round of latest report
   */
  function latestRoundData()
    external
    view
    virtual
    override
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    )
  {
    return (0, 0, 0, 0, 0);
  }

  function latestTimestamp() external view returns (uint256) {
    return 0;
  }

  function version() external view returns (uint256) {
    return 0;
  }
}
