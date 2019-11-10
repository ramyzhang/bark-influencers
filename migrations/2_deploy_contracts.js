const contracts = [ artifacts.require('./BarkMaker.sol') ]
const Web3 = require('web3')

module.exports = _deployer =>
  contracts.map(_contract =>
    // _deployer.deploy(_contract, 2, '0x0865de52036960077D4e756db90365576346152b', {value: 2000000}))
    _deployer.deploy(_contract));
