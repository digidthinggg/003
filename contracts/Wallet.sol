// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./interfaces/ILayer.sol";

contract Wallet {
  address layerAddr;

  function setLayerAddress(address _layerAddr) public virtual {
    layerAddr = _layerAddr;
  }

  struct amount = {
    min: uint256,
    max: uint256
  }

  string[] tokens;

  Layer[][] layerFlow;

  struct Requirement = {
    amount: amount;
    tokens: tokens;
    layerFlow: layerFlow;
  }

  // Requirements for user to add a layer.
  Requirement[] addLayerRequirements;

  // Requirements for user to update a layer.
  Requirement[] updateLayerRequirements;

  // Requirements for a user to remove a layer.
  Requirement[] removeLayerRequirements;

  // Requirements for a user to withdraw their tokens from product.
  Requirement[] reversalRequirements;
  
  // Requirements for a user to make a transfer.
  Requirement[] transferRequirements;

  event HandleLayerStartedEV();
  event HandleLayerSuccessEV();
  event HandleLayerFailureEV();

  function test() public virtual {
    require(address(layerAddr) != address(0), "layerAddr is not set");

    ILayer(layerAddr).executeLayer();
  }

  function handleLayerStarted() external {
    emit HandleLayerStartedEV();
  }

  function handleLayerSuccess() external {
    emit HandleLayerSuccessEV();
  }

  function handleLayerFailure() external {
    emit HandleLayerFailureEV();
  }
}
