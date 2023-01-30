// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./interfaces/ILayer.sol";

contract Wallet {
  address layerAddr;

  function setLayerAddress(address _layerAddr) public virtual {
    layerAddr = _layerAddr;
  }


  struct amountMinMax = {
    min: uint256,
    max: uint256
  }

  string[] tokensArr;

  Layer[][] layerFlow;

  struct Requirement = {
    amount: amountMinMax;
    tokens: tokensArr;
    layerFlow: layerFlow;
  }


  // Requirements to add a layer.
  Requirement[] addLayerRequirements;

  // Requirements to remove a layer.
  Requirement[] removeLayerRequirements;

  // Requirements to reverse secured tokens.
  Requirement[] reversalRequirements;

  // Requirements to make a transfer.
  Requirement[] transferRequirements;


  // Add a layer to layerFlow in Requirement.
  struct AddLayer {

    // Layer to add.
    Layer layer;

    // Find.
    // Match amount.
    amount: amountMinMax;
    // Match tokens.
    tokens: tokensArr;
    // Index.
    layerFlowRow: uint256;
    layerFlowCol: uint256;

    // Requirements to add layer.
    Requirement[] layerRequirements;
  }

  // We need initialized AddLayer struct. One only.

  // Pending add layers.
  AddLayer[] addLayerQueue;

  /**
    * Update is remove and add.
    */

  struct RemoveLayer {
    Layer layer;
    uint256 layerCol;

    Requirement[] layerRequirements;
  }

  // Pending remove layers.
  RemoveLayer[] removeLayerQueue;


  struct Reversal {
    amount: uint256;
    tokens: tokensArr;
    Requirement[] layerRequirements;
  }

  // Pending reversals.
  Reversal[] reversalQueue;


  struct Transfer {
    uint256 transferNum;
    address receiver;
    uint256 amount;
    Requirement[] layerRequirements;
    bool executed;
  }

  // Pending transfers.
  Transfer[] transferQueue;


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

  function executeTransfer() {
    //
  }
}
