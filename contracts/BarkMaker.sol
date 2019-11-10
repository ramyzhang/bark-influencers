pragma solidity ^0.5.0;

import "@openzeppelin/contracts/ownership/Ownable.sol";
import "./Bark.sol";

contract BarkMaker is Ownable {

    mapping(int => address) barkContractsMapping;
    int public numBarkContracts;

    function getBarkContracts(int _index) public view returns (address) {
      return barkContractsMapping[_index];
    }

    function getNumberOfContracts() public view returns (int) {
      return numBarkContracts;
    }

    function createNewBarkContract(
      uint256 _adQuota,
      address payable _influencerAddress
    ) public payable returns(int index) {
    // We also pass in the owner to be recognized by the contract, and ether amount
    //   for the owner to participate in the pot.
      Bark newContract = (new Bark).value(msg.value)({
        _adQuota: _adQuota,
        _influencerAddress: _influencerAddress,
        _owner: msg.sender
      });
      // Update with new contract info

      barkContractsMapping[numBarkContracts] = address(newContract);
      numBarkContracts++;
      return numBarkContracts - 1;
    }
}
