pragma solidity ^0.5.0;

import "./provableAPI.sol";
// import "github.com/provable-things/ethereum-api/provableAPI.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";
// import "./Ownable.sol";

contract Bark is usingProvable, Ownable {

    // event listeners for Provable query and final funds transfer
    event Transfer(address influencerAddress);
    event LogConstructorInitiated(string nextStep);
    event LogNewProvableQuery(string description);
    event LogAdConfirmations(uint256 numberOfPosts);

    // basic variables to store general information
    uint256 adQuota;
    address payable influencerAddress;
    string influencerHandle;
    string hashtag;
    uint256 public numberOfPosts;

    // initializing constructor: owner of the contract is the business
    constructor(uint256 _adQuota, address payable _influencerAddress, address _owner) payable public {
        if (_owner != msg.sender) {
          transferOwnership(_owner);
        }
        adQuota = _adQuota;
        influencerAddress = _influencerAddress;
        emit LogConstructorInitiated("Constructor was initiated! Call 'checkForAd()' to send the Provable Query.");
        // OAR = OraclizeAddrResolverI(0x6f485C8BF6fc43eA212E93BBF8ce046C7f1cb475);
    }

    // influencer calls this function to input their own information
    function helloInfluencer(string memory _influencerHandle, string memory _hashtag) payable public {
        if (msg.sender == influencerAddress) {
            influencerHandle = _influencerHandle;
            hashtag = _hashtag;
        } else {
            revert("Something wrong happened.");
        }
    }

    // Provable query to check for the number of ads posted
  	function checkForAd() payable public {
  		require(msg.value >= 0.004 ether, "Please send more ETH to cover query fee.");
  		if (provable_getPrice("URL") > address(this).balance) {
  			emit LogNewProvableQuery("Provable query was NOT sent, please add some ETH to cover for the query fee");
  		} else {
  		    emit LogNewProvableQuery("Provable query was sent, standing by for the answer...");
              provable_query("URL", string(abi.encodePacked('json(https://api.tumblr.com/v2/blog/', influencerHandle, '.tumblr.com/posts/text?api_key=LuKkhDrc4tProjJ1rNTWCnhvvucmV7cHKxYM1zVrTX0Q8AcwfJ&tag=', hashtag, ').response.total_posts')));
              // provable_query("URL", 'json(https://api.tumblr.com/v2/blog/genericinfluencer.tumblr.com/posts/text?api_key=LuKkhDrc4tProjJ1rNTWCnhvvucmV7cHKxYM1zVrTX0Q8AcwfJ&tag=ad).response.total_posts');
          }
  	}

    // Provable callback function
  	function __callback(bytes32 myid, string memory result) public {
  		// require(msg.sender != provable_cbAddress());
  		numberOfPosts = parseInt(result);
  		if (numberOfPosts >= adQuota) {
  			influencerPayout();
  		}
  		emit LogAdConfirmations(numberOfPosts);
  	}

    // final transfer function
    function influencerPayout() private {
        influencerAddress.transfer(address(this).balance);
        emit Transfer(influencerAddress);
    }
}
