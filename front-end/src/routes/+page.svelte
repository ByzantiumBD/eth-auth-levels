<script lang="ts">

	let connected= false;
	let counter= 0

    function connect() {
        connected = true;
    }
    function disconnect() {
        connected = false;
    }

</script>

<div id="background">

	<div id="top_bar">
		<button id="wallet" on:click={
			connected ? disconnect : connect
			}>
			<span style:font-size="25px" style:color="white">
				{
					connected 
					? "Disconnect your wallet"
					: "Connect your wallet" }
			</span>
		</button>
	</div>

	<div id="page">
		<div id="box">
			<span id="counter">{counter}</span>
			<button class="level">
				<span style:margin="8px">Level 1</span>
			</button>
			<button class="level">
				<span style:margin="8px">Level 2</span>
			</button>
			<button class="level">
				<span style:margin="8px">Level 3</span>
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
	}
	#top_bar {
		display: flex;
		flex-direction: column;
		justify-content: center;
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
