pragma solidity 0.8.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
contract myNFT is ERC721URIStorage {
  uint256 public tokenId;
  constructor () ERC721 ("myNFT", "MNT"){
    tokenId = 0;
  }

  mapping(uint256 => uint256) public tokenToPrice;
  function createCollec(string memory tokenURI) public returns (uint256) {
    _safeMint(msg.sender, tokenId);
    _setTokenURI(tokenId, tokenURI);
    tokenId = tokenId + 1;
    return tokenId;
  }

  function setSellingValue(uint256 _tokenId, uint256 price) external {
      require(_isApprovedOrOwner(_msgSender(), _tokenId), "ERC721: transfer caller is not owner nor approved");
      tokenToPrice[_tokenId] = price;
  }

    function buyNFT(uint256 _tokenId) external payable {
        require(tokenToPrice[_tokenId] != 0, "Token not sellable");
        require(msg.value == tokenToPrice[_tokenId], "Value send low or high");
        _transfer(ERC721.ownerOf(_tokenId), msg.sender, _tokenId);
        payable(ERC721.ownerOf(_tokenId)).transfer(msg.value);
        tokenToPrice[_tokenId] = 0;
    }
}
