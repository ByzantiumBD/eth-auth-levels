<script lang="ts">
	import {
		connected,
		chainId,
		defaultEvmStores as evm,
		web3
	} from 'svelte-web3'
	import ABI from "./ABI.json"
    import type { Readable } from 'svelte/store';
	import type { Contract } from 'web3-eth-contract';


	let counter = 0;
	let contract: Contract;
	let acc: Readable<string | null>;

	async function connect() {
		await evm.setProvider()

		acc = evm.selectedAccount;
		
		console.log($acc);
		

		contract = new $web3.eth.Contract(
			ABI as any,
			"0x9C8DA32970E07C1959B06D1Bab5D18cE3F096CF0"
		)
		updateCounter()
	}

	function disconnect() {
	}

	async function updateCounter() {
		if (contract == undefined) return;
		console.log("updating...");
		counter = await contract.methods.counter($acc).call(
			{from: $acc},
			"latest"
		)
	}

	async function callLevel(idx: number) {
		if (contract == undefined) return;
		await contract.methods.addAmount($acc, idx).send(
			{from: $acc}
		)
		updateCounter()
	}
</script>

<div id="background">

	<div id="top_bar">
		<span style:font-size="25px">
			{
				$connected
				? $chainId === 80001
					? "Connected"
					: ""
				: "Connect with an injected provider"
			}
		</span>
		{#if $connected && $chainId !== 80001}
			<span style:font-size="25px">
				Please switch to Mumbai testnet
			</span>
		{/if}
		<button id="wallet" on:click={
			$connected ? disconnect : connect
			}>
			<span style:font-size="25px" style:color="white">
				{
					$connected 
					? "Disconnect your wallet"
					: "Connect your wallet" 
				}
			</span>
		</button>
	</div>

	<div id="page">
		<div id="box">
			<span id="counter">{counter}</span>
			<button class="level" on:click={
				()=>callLevel(1)
			}>
				<span style:margin="8px">Level 1</span>
			</button>
			<button class="level" on:click={
				()=>callLevel(2)
			}>
				<span style:margin="8px">Level 2</span>
			</button>
			<button class="level" on:click={
				()=>callLevel(3)
			}>
				<span style:margin="8px">Level 1 & 2</span>
			</button>
		</div>
	</div>

</div>

<style>
	#background {
		display: flex;
		flex-direction: column;
		background-color: #f1f1f1;
		width: 100%;
		height: 100%;
		color: white;
	}
	#top_bar {
		display: flex;
		justify-content:space-between;
		align-items: center;
		align-self: flex-start;
		background-color: #352163;
		width: 100%;
		height: 8vh;
	}
	#wallet {
		background-color: #724ec3;
		border: none;
		padding: 12px;
		border-radius: 50px;
	}
	#page {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		width: 100%;
		height: 100%;
	}
	#counter {
		font-size: 50px;
		margin: 10px;
		padding-bottom: 50px;
		color: white;
	}
	.level {
		background-color: #724ec3;
		font-size: 30px;
		padding: 15px 25px;
		border: none;
		border-radius: 50px;
		margin:10px;
		color: white;
	}
	#box {
		display:flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		background-color: #352163;
		width: 45vw;
		padding: 20px;
		border-radius: 50px;
	}
</style>
