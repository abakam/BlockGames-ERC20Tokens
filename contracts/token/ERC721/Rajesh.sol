// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/**
 * @notice Issue NFTs for specific assets.
 * @dev These assets are verifiable and the ownership of assets also verifiable
 */
contract Rajesh is ERC721, ERC721URIStorage, Ownable {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    mapping(string => uint8) hashes;

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {}

    /**
     * @notice Mint an NFT for a given IPFS hash if no token has been minted for that hash
     * @param recipient The account that would be awarded the minted NFT
     * @param hash The IPFS hash for the asset that the NFT is being created for.
     * @param metadata The link to the JSON metadata for the asset
     * @return tokenId The identifier of the minted NFT
     *
     */
    function awardItem(address recipient, string memory hash, string memory metadata) public onlyOwner returns(uint256) {

        require(hashes[hash] != 1, "This hash has already been minted");

        hashes[hash] = 1;

        uint256 tokenId = _tokenIds.current();
        _tokenIds.increment();
        _safeMint(recipient, tokenId);
        _setTokenURI(tokenId, metadata);

        return tokenId;
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}