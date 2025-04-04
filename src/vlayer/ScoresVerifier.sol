// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Proof} from "vlayer-0.1.0/Proof.sol";
import {Verifier} from "vlayer-0.1.0/Verifier.sol";
import { ForestSlasher } from "../ForestSlasher.sol";
import { ScoresProver } from "./ScoresProver.sol";

contract ScoresVerifier is Verifier {
    address public prover;

    constructor(address _prover) {
        prover = _prover;
    }

    function verifyScores(Proof calldata, ForestSlasher.EpochScoreAggregate[] memory aggregates)
        public
        onlyVerified(prover, ScoresProver.proveScores.selector)
        returns (bool)
    {
        // TODO: Implement 
        return true;
    }
}
