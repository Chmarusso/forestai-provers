import { createVlayerClient } from "@vlayer/sdk";
import {
  getConfig,
  createContext,
  deployVlayerContracts,
  waitForContractDeploy,
} from "@vlayer/sdk/config";

import proverSpec from "../out/ScoresProver.sol/ScoresProver";
import verifierSpec from "../out/ScoresVerifier.sol/ScoresVerifier";
import forestSlasherSpec from "../out/ForestSlasher.sol/ForestSlasher";

const config = getConfig();
const {
  chain,
  ethClient,
  account: john,
  proverUrl,
  confirmations,
} = await createContext(config);

const slasherDeployTx = await ethClient.deployContract({
  abi: forestSlasherSpec.abi,
  bytecode: forestSlasherSpec.bytecode.object,
  account: john,
  args: [],
});

const forestSlasherAddr = await waitForContractDeploy({
  client: ethClient,
  hash: slasherDeployTx,
});

const { prover, verifier } = await deployVlayerContracts({
  proverSpec,
  verifierSpec,
  proverArgs: [forestSlasherAddr],
  verifierArgs: [],
});

console.log("Proving...");
const vlayer = createVlayerClient({
  url: proverUrl,
  token: config.token,
});

const hash = await vlayer.prove({
  address: prover,
  proverAbi: proverSpec.abi,
  functionName: "proveScores",
  args: [],
  chainId: chain.id,
});
const result = await vlayer.waitForProvingResult({ hash });
const [proof, aggregates] = result;

console.log("Proof result:", result);
console.log("Aggregates:", aggregates);

await ethClient.writeContract({
  address: forestSlasherAddr,
  abi: forestSlasherSpec.abi,
  functionName: "aggregateScores",
  args: [],
  account: john,
});

const verificationHash = await ethClient.writeContract({
  address: verifier,
  abi: verifierSpec.abi,
  functionName: "verifyScores",
  args: [proof, aggregates],
  account: john,
});

const receipt = await ethClient.waitForTransactionReceipt({
  hash: verificationHash,
  confirmations,
  retryCount: 60,
  retryDelay: 1000,
});

console.log(`Verification result: ${receipt.status}`);
