# eth-auth-levels
This repo shows how to implement a simple auth scheme to allow different profiles to operate for you.

You have 8 different Authorization Levels, independent of each other. They're represented by a uint8 on the blockchain.

```
 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | Profile Value
----------------------------------------------
 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |      0       
 0 | 0 | 0 | 0 | 0 | 1 | 0 | 1 |      5
```

You can always reset the authentication level of an address.

Example workflow:
 - Alice authorizes address Bob to perform operations with auth level 1 & 3

 - Bob tries to transfer an NFT, which requires authentication level 4 & 2

 - Bob is not allowed to transfer an NFT
 - Bob tries to transfer an asset, which requires authentication level 3
 - Bob is allowed to transfer the asset.

Front-end is a simple example to show a good use case for this authentication scheme:
Bob can be an EVM profile created and managed by the front-end, which can thus approve without the need of user interaction.