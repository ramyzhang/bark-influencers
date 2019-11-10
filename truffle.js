var HDWalletProvider = require('truffle-hdwallet-provider');

var infuraApiKey = process.env.INFURA_KEY;

var mnemonic = process.env.MNEMONIC;

module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: '5777'
    },
    ropsten: {
      provider: function() {
        return new HDWalletProvider(mnemonic, 'https://ropsten.infura.io/v3' + infuraApiKey);
      },
      network_id: 3,
      gas: 4612388
    }
  }
};
