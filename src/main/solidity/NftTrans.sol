// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


interface IOZERC721 {
    /**
 * @dev Returns the number of tokens in ``owner``'s account.
 */
    function balanceOf(address owner) external view returns (uint256 balance);

    /**
     * @dev Returns the owner of the `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function ownerOf(uint256 tokenId) external view returns (address owner);

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be have been allowed to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) external;

    /**
     * @dev Transfers `tokenId` token from `from` to `to`.
     *
     * WARNING: Usage of this method is discouraged, use {safeTransferFrom} whenever possible.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 tokenId) external;

    /**
     * @dev Gives permission to `to` to transfer `tokenId` token to another account.
     * The approval is cleared when the token is transferred.
     *
     * Only a single account can be approved at a time, so approving the zero address clears previous approvals.
     *
     * Requirements:
     *
     * - The caller must own the token or be an approved operator.
     * - `tokenId` must exist.
     *
     * Emits an {Approval} event.
     */
    function approve(address to, uint256 tokenId) external;

    /**
     * @dev Returns the account approved for `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function getApproved(uint256 tokenId) external view returns (address operator);

    /**
     * @dev Approve or remove `operator` as an operator for the caller.
     * Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.
     *
     * Requirements:
     *
     * - The `operator` cannot be the caller.
     *
     * Emits an {ApprovalForAll} event.
     */
    function setApprovalForAll(address operator, bool _approved) external;

    /**
     * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
     *
     * See {setApprovalForAll}
     */
    function isApprovedForAll(address owner, address operator) external view returns (bool);

    /**
      * @dev Safely transfers `tokenId` token from `from` to `to`.
      *
      * Requirements:
      *
      * - `from` cannot be the zero address.
      * - `to` cannot be the zero address.
      * - `tokenId` token must exist and be owned by `from`.
      * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
      * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
      *
      * Emits a {Transfer} event.
      */
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;

    /**
 * @dev Returns the token collection name.
 */
    function name() external view returns (string memory);

    /**
     * @dev Returns the token collection symbol.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the Uniform Resource Identifier (URI) for `tokenId` token.
     */
    function tokenURI(uint256 tokenId) external view returns (string memory);

    /**
 * @dev Returns the total amount of tokens stored by the contract.
 */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns a token ID owned by `owner` at a given `index` of its token list.
     * Use along with {balanceOf} to enumerate all of ``owner``'s tokens.
     */
    function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256 tokenId);

    /**
     * @dev Returns a token ID at a given `index` of all the tokens stored by the contract.
     * Use along with {totalSupply} to enumerate all tokens.
     */
    function tokenByIndex(uint256 index) external view returns (uint256);
}

contract NftTrans {
    IOZERC721 private ozerc721;

    // Percentage to owner of SupeRare. (* 10) to allow for < 1%
    uint256 public maintainerPercentage = 30;

    // Percentage to creator of artwork. (* 10) to allow for tens decimal.
    uint256 public creatorPercentage = 100;

    // Mapping from token ID to the address offering
    mapping(uint256 => address payable) private tokenOfferer;

    // Mapping from token ID to the current offer amount
    mapping(uint256 => uint256) private tokenCurrentOffer;

    // Mapping from token ID to the owner sale price
    mapping(uint256 => uint256) private tokenSalePrice;

    // Mapping from token ID to whether the token has been sold before.
    mapping(uint256 => bool) private tokenSold;

    event Offer(address indexed _offerer, uint256 indexed _amount, uint256 indexed _tokenId);
    event AcceptOffer(address indexed _offerer, address indexed _seller, uint256 _amount, uint256 indexed _tokenId);
    event CancelOffer(address indexed _offerer, uint256 indexed _amount, uint256 indexed _tokenId);
    event Sold(address indexed _buyer, address indexed _seller, uint256 _amount, uint256 indexed _tokenId);
    event SalePriceSet(uint256 indexed _tokenId, uint256 indexed _price);

    /**
     * @dev Guarantees msg.sender is not the owner of the given token
     * @param _tokenId uint256 ID of the token to validate its ownership does not belongs to msg.sender
     */
    modifier notOwnerOf(IOZERC721 _ozerc721, uint256 _tokenId) {
        require(_ozerc721.ownerOf(_tokenId) != msg.sender);
        _;
    }

    constructor(address _ozerc721) {
        ozerc721 = IOZERC721(_ozerc721);
    }

    function getNftName() external view returns (string memory){
        return ozerc721.name();
    }

    function setNtfAddr(address _newNftAddr) external {
        ozerc721 = IOZERC721(_newNftAddr);
    }

    /**
    * @dev Offers on the token, replacing the offer if the offer is higher than the current offer. You cannot offer on a token you already own.
    * @param _tokenId uint256 ID of the token to offer on
    */
    function offer(uint256 _tokenId) external payable notOwnerOf(ozerc721, _tokenId) {
        require(isGreaterOffer(_tokenId));
        returnCurrentOffer(_tokenId);
        tokenOfferer[_tokenId] = payable(msg.sender);
        tokenCurrentOffer[_tokenId] = msg.value;
        emit Offer(msg.sender, msg.value, _tokenId);
    }

    /**
    * @dev Gets the current offer and offerer of the token
    * @param _tokenId uint256 ID of the token to get offer details
    * @return offer amount and offerer address of token
    */
    function currentOfferDetailsOfToken(uint256 _tokenId) public view returns (uint256, address) {
        return (tokenCurrentOffer[_tokenId], tokenOfferer[_tokenId]);
    }

    /**
    * @dev Internal function to return funds to current offerer.
    * @param _tokenId uint256 ID of the token with the standing offer
    */
    function returnCurrentOffer(uint256 _tokenId) private {
        uint256 currentOffer = tokenCurrentOffer[_tokenId];
        address payable currentOfferer = tokenOfferer[_tokenId];
        if(currentOfferer != address(0)) {
            currentOfferer.transfer(currentOffer);
        }
    }

    /**
    * @dev Internal function to check that the offer is larger than current offer
    * @param _tokenId uint256 ID of the token with the standing offer
    */
    function isGreaterOffer(uint256 _tokenId) internal view returns (bool) {
        return msg.value > tokenCurrentOffer[_tokenId];
    }

}
