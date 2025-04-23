# Example vlayer provers for Forest Protocol

## Install vlayer CLI 
```shell
curl -SL https://install.vlayer.xyz | bash
```
More info [in the docs](https://book.vlayer.xyz/getting-started/installation.html)

## Check ForestAI Slasher contract address 
- `vlayer/prove.ts` line 38
- Remove mock at `ScoresProver.sol` (optional)

## Build contracts

```shell
cd {this project}
forge build --via-ir
```

## Start local development 
```shell
cd vlayer
bun install
bun run devnet:up
```

## Run local proving
```shell
bun run prove:dev
```