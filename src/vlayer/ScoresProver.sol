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
        ForestSlasher.EpochScoreAggregate[] memory aggregates = forestSlasher.aggregateScores();

        return (proof(), aggregates);
    }
}