// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "./IStarknetCore.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract L1DataBridge is Ownable {

    ///////////////
    /// Storage ///
    ///////////////

    //Contracts
    IStarknetCore immutable public starknetCore;
    uint256 public l2_contract;

    ///////////////////
    /// Constructor ///
    ///////////////////

    constructor(
        IStarknetCore starknetCore_,
        uint256 l2_contract_
    ) payable {
        require(address(starknetCore_) != address(0));
        starknetCore = starknetCore_;
        l2_contract = l2_contract_;
    }

    ////////////////////////
    ///     Getters      ///
    ////////////////////////
    function getL2Contract() public view returns(uint256 value) {
        return l2_contract;
    }

    ////////////////////////
    /// Public Functions ///
    ////////////////////////

    function updateL2Contract(uint256 l2_new_contract_) public onlyOwner {
        l2_contract = l2_new_contract_;
    }

    function messageConsumer() public onlyOwner {

        uint256[] memory payload = new uint256[](1);
        payload[0] = 0;
        starknetCore.consumeMessageFromL2(l2_contract, payload);
    }

}
