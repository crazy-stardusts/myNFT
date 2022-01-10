pragma solidity 0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
contract myNFT is ERC721URIStorage {
  uint256 public tokenId;
  constructor () ERC721 ("myNFT", "MNT"){
    tokenId = 0;
  }
  function createCollec(string memory tokenURI) public returns (uint256) {
    _safeMint(msg.sender, tokenId);
    _setTokenURI(tokenId, tokenURI);
    tokenId = tokenId + 1;
    return tokenId;
  }
}
