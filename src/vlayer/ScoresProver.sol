// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.22;

import { ForestSlasher } from "../ForestSlasher.sol";
import { Prover } from "vlayer-0.1.0/Prover.sol";
import { Proof } from "vlayer-0.1.0/Proof.sol";

contract ScoresProver is Prover {
    ForestSlasher public immutable forestSlasher;

    constructor(ForestSlasher _forestSlasher) {
        forestSlasher = _forestSlasher;
    }

    function proveScores() public returns (Proof memory, ForestSlasher.EpochScoreAggregate[] memory) {
        // TODO: Call real aggregateScores() function
        // Get aggregates from the contract
        // ForestSlasher.EpochScoreAggregate[] memory aggregates = forestSlasher.aggregateScores();

        // TODO: Temp mock, remove this if above is implemented
        ForestSlasher.EpochScoreAggregate[] memory aggregates = new ForestSlasher.EpochScoreAggregate[](3);
        for (uint256 i = 0; i < 3; i++) {
            aggregates[i] = ForestSlasher.EpochScoreAggregate({
                ptAddr: address(uint160(i)),
                revenueAtEpochClose: uint256(i),
                provRanks: new uint256[2][](0),
                valRanks: new uint256[2][](0)
            });
        }

        return (proof(), aggregates);
    }
}