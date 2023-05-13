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
	import type { Account } from 'web3-core';
    import Popup from "./popup.svelte";


	let counter = "connect...";
	let contract: Contract;
	let acc: Readable<string | null>;
	let isPopupActive = false;
	let temp: Account;
	let status = "waiting for connection...";


	async function connect() {
		status = "connecting wallet..."
		await evm.setProvider()

		acc = evm.selectedAccount;
		
		console.log($acc);
		//const prov = $web3.currentProvider;
		//$web3.setProvider(tempWeb3Provider)
		temp = $web3.eth.accounts.create()
		console.log(temp.address);
		status = "requesting gas tokens to temp wallet... "
		$web3.eth.accounts.wallet.add(temp.privateKey);
		await $web3.eth.sendTransaction({
			from: $acc!,
			to: temp.address,
			value: "1000000000000000"
		})
		//$web3.setProvider(prov)

		contract = new $web3.eth.Contract(
			ABI as any,
			"0x9C8DA32970E07C1959B06D1Bab5D18cE3F096CF0"
		)

		updateCounter()
	}

	async function updateCounter() {
		if (contract == undefined) return;
		status = "updating counter..."
		counter = await contract.methods.counter($acc).call(
			{from: $acc},
			"latest"
		)
		status = "ready"
	}

	async function callLevel(idx: number) {
		if (contract == undefined) return;
		status = "calling contract function..."

		let tx = contract.methods.addAmount($acc, idx)
		try {
			await tx.send(
				{
					from: temp.address,
					gasLimit: await tx.estimateGas({
						from: temp.address
					})
				}
			)
			status = "transaction complete"
			updateCounter()
		} catch (e) {
			status = "error: you weren't allowed to do that"
		}
	}

	async function changeAllowance(lvl: number) {
		status = "changing allowance"
		
		if (contract == undefined) return;
		await contract.methods.authorize(temp.address, lvl).send(
			{from: $acc}
		)
		status = "allowance change complete"
		isPopupActive = false
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
			$connected ? ()=>{} : connect
			}>
			<span style:font-size="25px" style:color="white">
				{
					$connected 
					? "Connected!"
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
		<button id="select" 
		on:click={()=>{isPopupActive = true}}>
			Select allowed levels
		</button>
		<span style:color="black">Status: {status}</span>
	</div>

</div>

{#if isPopupActive}
	<Popup close={()=>{isPopupActive = false}}
		save={changeAllowance}/>
{/if}

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
		font-weight: bold;
		border: none;
		padding: 12px 20px;
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
		font-weight: bold;
		margin: 5px;
		padding: 15px 0;
		color: white;
	}
	.level {
		background-color: #724ec3;
		font-size: 30px;
		padding: 15px 25px;
		border: none;
		border-radius: 50px;
		margin:8px;
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
	#select {
		background-color: #724ec3;
		margin: 25px;
		padding: 20px 30px;
		font-size: 25px;
		font-weight: bold;
		color: #f1f1f1;
		border-radius: 50px;
		border: none;
	}
</style>
