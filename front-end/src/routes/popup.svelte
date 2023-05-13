<script lang="ts">

</script>

<div id="backgroundup">

    <div id="popup">
        <span id="choose">Choose authorization level</span>

        <label class="checkmark">
            <input type="checkbox">
            Level 1
        </label>

        <label class="checkmark">
            <input type="checkbox">
            Level 2
        </label>

        <label class="checkmark">
            <input type="checkbox">
            Level 3
        </label>

        <button id="buttonup">OK</button>
    </div>

    <button id="exit">Exit</button>

</div>

<style>
    #backgroundup {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        position: absolute;
        width: 100vw;
        height: 100vh;
        background-color: #00000099;
    }

    #popup {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        width: 50vw;
        height: 50ch;
        background-color: #9e70be;
        opacity: 100%;
        border-radius: 30px;
        border: 8px solid #724ec3;
    }

    #choose {
        color: white;
        font-size: 35px;
        margin: 30px;
    }

    label {
        margin: 10px;
        color: white;
        font-size: 30px;
        text-align: center;
    }

    input {
        margin: 5px;
        width: 2vw;
        height: 2vh;
        border: none;
    }
    #buttonup {
        background-color: #724ec3;
        border: none;
        color: white;
        padding: 10px 40px;
        border-radius: 50px;
        margin: 30px;
        font-size: 30px;
    }

    #exit {
        margin: 30px;
        background-color: #ffffff;
        border: none;
        padding: 20px 40px;
        border-radius: 50px;
        font-size: 25px;
        font-weight: bold;
        color: #352163;
        border: 6px solid #724ec3;

    }
</style>