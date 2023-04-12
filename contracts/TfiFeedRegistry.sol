// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract TfiFeedRegistry is Initializable, OwnableUpgradeable {
  function initialize(
  ) public initializer {
    __Ownable_init();
  }
}