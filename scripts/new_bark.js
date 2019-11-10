const BarkMaker = artifacts.require('./BarkMaker.sol');
const Bark = artifacts.require('./Bark.sol');
const Web3 = require('web3');

module.exports = async (callback) => {
  const barkMaker = await BarkMaker.deployed();
  await barkMaker.createNewBarkContract(3, '0x577f9B33a0C22Ed55153b031c5514b1703c7E09E', {value: 2000000});

  const numberOfChildren = barkMaker.numBarkContracts().call(function(err, res) {
    console.log(res);
  })
  // const newIndex = await barkMaker.getNumberOfContracts();
  //
  // const address0 = await barkMaker.getBarkContracts('0');
  // const bark0 = await Bark.at(address0);
  // const currentIndex = newIndex - 1;

  // const address0 = await barkMaker.getBarkContracts('0');

  // await bark0.helloInfluencer("genericinfluencer", "ad", {from:'0x577f9B33a0C22Ed55153b031c5514b1703c7E09E'});
  // // const newIndex = await barkMaker.getNumberOfContracts()
  // // const curIndex = newIndex - 1;
  //
  // const address0 = await barkMaker.getBarkContracts('0');
  // const address1 = await barkMaker.getBarkContracts('1');
  //
  // const bark0 = await Bark.at(address0)
  // const bark1 = await Bark.at(address1)
  //
  // await bark0.helloInfluencer("genericinfluencer", "ad", {from:'0x577f9B33a0C22Ed55153b031c5514b1703c7E09E'});
  // // const handle = await bark0.deployed().then(function(contract) {contract.influencerHandle.call().then(function(v) {console.log(v)})})
  //
  // console.log(indexeu);
  callback()
}
