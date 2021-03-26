// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

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

    function tokenCreator(uint256 _tokenId) external view returns (address);
}


/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}


/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
interface IERC721Receiver {
    /**
     * @dev Whenever an {IERC721} `tokenId` token is transferred to this contract via {IERC721-safeTransferFrom}
     * by `operator` from `from`, this function is called.
     *
     * It must return its Solidity selector to confirm the token transfer.
     * If any other value is returned or the interface is not implemented by the recipient, the transfer will be reverted.
     *
     * The selector can be obtained in Solidity with `IERC721.onERC721Received.selector`.
     */
    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) external returns (bytes4);
}

contract NftAuction is Ownable, IERC721Receiver{
    IOZERC721 private ozerc721;
    address public ozerc721Addr;

    enum AuctionType {None, Reserve, Schedule}

    //Reserve Auction: NotStart -> StartBid -> End
    //Schedule Auction: NotStart -> Start -> StartBid -> End
    enum AuctionState {None, Start, Bidding, End}

    struct RAuction{ //Reserve Auction
        uint256 startPrice;
    }

    struct SAuction{ //Schedule Auction
        uint256 startPrice;
        uint256 startBlock;
        uint256 durBlocks;
    }

    struct OngoingAuction { //Start Auction put here
        AuctionState state; //Start, Bidding, End
        uint256 startBlock;
        uint256 durBlocks;
    }

    struct BidAuction{ // StartBid Auction's bid info put here
        uint256 currentBid;
        address payable currentBidder;
    }

    //tokenId to AuctionType, this is used to check a token is in Auction or not.
    mapping(uint256=>AuctionType) public auctionType;

    //tokenId to Reserve Auction.
    mapping(uint256=>RAuction) public rAuctions;

    //tokenId to Schedule Auction.
    mapping(uint256=>SAuction) public sAuctions;

    //tokenId to OngoingAuction, when started
    mapping(uint256=>OngoingAuction) public ongoingAuctions;

    //tokenId to AuctionBid, when in Bidding or End state
    mapping(uint256=>BidAuction) public bidAuctions;

    //tokenId to Origin Owner. when an auction start, the token will be mortgaged to this address.
    mapping(uint256=>address) public origOwner;

    event Erc721Changed(address indexed _from, address indexed _to);
    event ScheduleAuction(address indexed erc721, uint256 indexed tokenId, address indexed tokenOwner, uint256 startPrice, uint256 startBlock, uint256 durBlocks);
    event ReserveAuction(address indexed erc721, uint256 indexed tokenId, address indexed tokenOwner, uint256 startPrice, uint256 durBlocks);
    event CancelAuction(address indexed erc721, uint256 indexed tokenId, address indexed tokenOwner);
    event Bid(address indexed erc721, uint256 indexed tokenId, address indexed newBidder, uint256 bidValue, address oldBidder, uint256 newDurBlocks, bool triggerAuction);
    event Pay(address indexed payAddr,  uint256 payValue); //for returnBid: payValue is 1.03 times of value.
    event SettleAuction(address indexed erc721, uint256 indexed tokenId, address indexed buyer, address seller, uint256 price);

    /**
     * @dev Throws if address is not ERC721.
     */
    modifier _onlyErc721(address _erc721Addr) {
        require(IERC165(_erc721Addr).supportsInterface(0x80ac58cd), "NftAuction: address must be ERC721");
        _;
    }

    modifier _onlyTokenApprover(IOZERC721 _ozerc721, uint256 tokenId) {
        address sender = _msgSender();
        require(_ozerc721.ownerOf(tokenId) == sender
                || _ozerc721.getApproved(tokenId) == sender
                || _ozerc721.isApprovedForAll(_ozerc721.ownerOf(tokenId), sender)
                || origOwner[tokenId] == sender,
                "NftAuction: operator is not approved");
        _;
    }

    //TODO:test
    // constructor(address _ozerc721) _onlyErc721(_ozerc721){
    //     ozerc721Addr = _ozerc721;
    //     ozerc721 = IOZERC721(_ozerc721);
    //     emit Erc721Changed(address(0), _ozerc721);
    // }
    constructor() {

    }

    //TODO: test
    function getAddr() view external returns(address){
        return address(this);
    }

    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) external override returns (bytes4){
        return IERC721Receiver.onERC721Received.selector;
    }

    function setErc721Addr(address _ozerc721) onlyOwner _onlyErc721(_ozerc721) external {
        require(ozerc721Addr != _ozerc721, "NftAuction: new ERC721 address is same to old address");
        address oldAddr = ozerc721Addr;
        ozerc721Addr = _ozerc721;
        ozerc721 = IOZERC721(_ozerc721);
        emit Erc721Changed(oldAddr, ozerc721Addr);
    }

    /**
     * @dev create a schedule auction, which has start-time and finish-time. start price can be zero.
     *
     * Requirements:
     * - `_tokenId` must exist.
     * - `_startPrice` can be zero.
     * - `_startBlock` when this _startBlock is mined, the auction starts
     * - `_durBlocks` when _startBlock+_durBlocks is mined, the auction ends.
     */
    //    function scheduleAuction(uint256 _tokenId, uint256 _startPrice, uint256 _startBlock, uint256 _durBlocks) _onlyTokenApprover(ozerc721, _tokenId) external {
    function scheduleAuction(uint256 _tokenId, uint256 _startPrice, uint256 _startBlock, uint256 _durBlocks) external {
        AuctionType aType = auctionType[_tokenId];
        require(aType == AuctionType.None, "NftAuction: tokenId should not been in auction");
        require(_startBlock>block.number+70, "NftAuction: startTime must be 15 mins later");
        require(_durBlocks>277, "NftAuction: Schedule auction must last at least 1 hour");
//        ozerc721.safeTransferFrom(ozerc721.ownerOf(_tokenId), address(this), _tokenId); //TODO
        origOwner[_tokenId] =
        auctionType[_tokenId] = AuctionType.Schedule;
        sAuctions[_tokenId] = SAuction({startPrice:_startPrice, startBlock:_startBlock, durBlocks:_durBlocks});
        //TODO: emit ScheduleAuction(ozerc721Addr, _tokenId, ozerc721.ownerOf(_tokenId), _startPrice, _startBlock, _durBlocks);
    }

    /**
     * @dev create a reserve auction, which has a start price. when a bid is reached, a 24 hours auction is started automatically.
     *
     * Requirements:
     * - `_tokenId` must exist.
     * - `_startPrice` must have value bigger than zero
     * - `_durBlocks` when _startBlock+_durBlocks is mined, the auction ends.
     */
    //    function reserveAuction(uint256 _tokenId, uint256 _startPrice, uint256 _durBlocks)  _onlyTokenApprover(ozerc721, _tokenId)  external {
    function reserveAuction(uint256 _tokenId, uint256 _startPrice, uint256 _durBlocks) external {
        AuctionType aType = auctionType[_tokenId];
        require(aType == AuctionType.None, "NftAuction: tokenId should not been in auction");
        require(_startPrice>0, "NftAuction: startPrice must have value");
        require(_durBlocks>277, "NftAuction: Schedule auction must last at least 1 hour");
        auctionType[_tokenId] = AuctionType.Reserve;
        rAuctions[_tokenId] = RAuction({startPrice:_startPrice});
        //TODO: emit ReserveAuction(ozerc721Addr, _tokenId, ozerc721.ownerOf(_tokenId), _startPrice, _durBlocks);
    }


    /**
     * @dev cancel an auction before it starts.
     *
     * Requirements:
     * - `_tokenId` must exist.
     */
//    function cancelAuction(uint256 _tokenId) _onlyTokenApprover(ozerc721, _tokenId) external {
    function cancelAuction(uint256 _tokenId) external {
        AuctionType aType = auctionType[_tokenId];
        require(aType != AuctionType.None, "NftAuction: tokenId should been in auction");
        AuctionState aState = ongoingAuctions[_tokenId].state;
        if(aType == AuctionType.Reserve){
            require(aState == AuctionState.None, "NftAuction: reserve auction already start");
            delete rAuctions[_tokenId];
        }else{ // AuctionType.Schedule
            require(block.number < sAuctions[_tokenId].startBlock, "NftAuction: schedule auction already start");
            delete sAuctions[_tokenId];
        }

        delete auctionType[_tokenId];
        //TODO: emit CancelAuction(ozerc721Addr, _tokenId, _msgSender());
    }

    /**
     * @dev correct the token auction state.
     */
//    function correctTokenState(uint256 _tokenId) internal {
//        AuctionType aType = auctionType[_tokenId];
//        if(aType == AuctionType.Reserve){
//            if(ongoingAuctions[_tokenId].state )
//        } else if(aType == AuctionType.Schedule){
//
//        }
//    }


    /**
     * @dev bid a token in an auction with value. the payed value is 1.03 times of bid _value.
     *
     * Requirements:
     * - `_tokenId` must exist.
     * - `_value` must bid value.
     */
    function bid(uint256 _tokenId, uint256 _value) external payable {

    }

    /**
     * @dev settle a finished auction. payout the values.
     *
     * Requirements:
     * - `_tokenId` must exist.
     */
    function settleAuction(uint256 _tokenId) external {

    }


}
