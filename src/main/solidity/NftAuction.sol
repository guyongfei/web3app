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

interface NftTokenSold {
    function setTokenSold(uint256 tokenId) external;
    function getTokenSold(uint256 tokenId) view external returns(bool);
}

contract NftAuction is Ownable, IERC721Receiver{
    IOZERC721 private ozerc721;
    address public ozerc721Addr;

    NftTokenSold private nftTokenSold;
    address public ntfTokenSoldAddr;

    event Erc721Changed(address indexed _from, address indexed _to);
    event NtfTokenSoldChanged(address indexed _from, address indexed _to);
    event Payoff(address indexed payAddr, uint256 payValue);

    // Percentage to owner of Platform for trans fee. 3%
    uint256 public maintainerTransPer = 30;
    // Percentage to owner of Platform for first trans fee. 15%
    uint256 public firstHandFeePer = 150;
    // Percentage to creator for n-hands trans fee. 10%
    uint256 public secondHandFeePer = 100;


    // Following are for the offer and buy.
    struct OfferItem{ // struct storing offer
        address offerer;
        uint256 offerValue;
        uint256 payValue;
    }
    // Mapping from token ID to OfferItem
    mapping(uint256 => OfferItem) private offers;
    // Mapping from token ID to the owner sale price
    mapping(uint256 => uint256) private tokenSalePrice;

    event Offer(address indexed erc721, address indexed _offerer, uint256 _tokenId, uint256 _amount);
    event CancelOffer(address indexed erc721, address indexed _offerer, uint256 indexed _tokenId, uint256 _amount);
    event AcceptOffer(address indexed erc721, address indexed _offerer, address indexed _seller, uint256 _amount, uint256 indexed _tokenId);
    event SalePriceSet(address indexed erc721, uint256 indexed _tokenId, uint256 indexed _price);
    event Buy(address indexed erc721, address indexed _buyer, address indexed _seller, uint256 _amount, uint256 indexed _tokenId);


    // Following are for the Reserve Auction and Schedule Auction
    enum AuctionType {None, Reserve, Schedule}

    struct RAuction{ //Planned Reserve Auction
        uint256 startPrice;
        uint256 durBlocks;
    }

    struct SAuction{ //Planned Schedule Auction
        uint256 startPrice;
        uint256 startBlock;
        uint256 durBlocks;
    }

    struct BiddingAuction { //Auction in bidding.
        uint256 startBlock;
        uint256 durBlocks;
        uint256 currentBid;
        address currentBidder;
        uint256 payValue;
    }

    //tokenId to AuctionType, this is used to check a token is in Auction or not.
    mapping(uint256=>AuctionType) public auctionType;
    //tokenId to Reserve Auction.
    mapping(uint256=>RAuction) public rAuctions;
    //tokenId to Schedule Auction.
    mapping(uint256=>SAuction) public sAuctions;
    //tokenId to BiddingAuction, only auctions with bids will be put here.
    mapping(uint256=>BiddingAuction) public biddingAuctions;
    //tokenId to Origin Owner. when an auction start or a schedule auction is planned, the token will be transferred to this contract address as mortgage.
    mapping(uint256=>address) public origOwner;

    event ScheduleAuction(address indexed erc721, uint256 indexed tokenId, address indexed tokenOwner, uint256 startPrice, uint256 startBlock, uint256 durBlocks);
    event ReserveAuction(address indexed erc721, uint256 indexed tokenId, address indexed tokenOwner, uint256 startPrice, uint256 durBlocks);
    event CancelAuction(address indexed erc721, uint256 indexed tokenId, address indexed tokenOwner);
    event Bid(address indexed erc721, uint256 indexed tokenId, address indexed newBidder, uint256 bidValue, address oldBidder, uint256 newDurBlocks, bool triggerAuction);
    event SettleAuction(address indexed erc721, uint256 indexed tokenId, address indexed buyer, address seller, uint256 price);


    /**
     * @dev Throws if address is not ERC721.
     */
    modifier _onlyErc721(address _erc721Addr) {
        require(IERC165(_erc721Addr).supportsInterface(0x80ac58cd), "NftAuction: address must be ERC721");
        _;
    }

    /**
     * @dev Guarantees msg.sender is not the owner of the given token
     * @param _ozerc721 IOZERC721 indicating ERC721 contract
     * @param _tokenId uint256 ID of the token to validate its ownership does not belongs to msg.sender
     */
    modifier _notOwnerOf(IOZERC721 _ozerc721, uint256 _tokenId) {
        require(_ozerc721.ownerOf(_tokenId) != _msgSender(), "NftAuction: must not be token owner");
        _;
    }

    modifier _payValueValid(uint256 _value) {
        uint256 minPayValue = _value + (_value * maintainerTransPer / 1000);
        require(minPayValue > _value && msg.value >= minPayValue, "NftAuction: payValue must be greater than _value");
        _;
    }

    modifier _onlyTokenApprover1(IOZERC721 _ozerc721, uint256 tokenId) {
        address sender = _msgSender();
        require(_ozerc721.ownerOf(tokenId) == sender
        || _ozerc721.getApproved(tokenId) == sender
        || _ozerc721.isApprovedForAll(_ozerc721.ownerOf(tokenId), sender),
            "NftAuction: operator is not approved");
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

    modifier _notTokenApprover(IOZERC721 _ozerc721, uint256 tokenId) {
        address sender = _msgSender();
        require(_ozerc721.ownerOf(tokenId) != sender
        && _ozerc721.getApproved(tokenId) != sender
            && !_ozerc721.isApprovedForAll(_ozerc721.ownerOf(tokenId), sender)
            && origOwner[tokenId] != sender,
            "NftAuction: operator is approver");
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

    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) external pure override returns (bytes4){
        return IERC721Receiver.onERC721Received.selector;
    }

    function setErc721Addr(address _ozerc721) onlyOwner _onlyErc721(_ozerc721) external {
        require(ozerc721Addr != _ozerc721, "NftAuction: new ERC721 address is same to old address");
        address oldAddr = ozerc721Addr;
        ozerc721Addr = _ozerc721;
        ozerc721 = IOZERC721(_ozerc721);
        emit Erc721Changed(oldAddr, ozerc721Addr);
    }

    function setNtfTokenSold(address _ntfTokenSoldAddr) onlyOwner external {
        require(ntfTokenSoldAddr != _ntfTokenSoldAddr, "NtfAuction: new NftTokenSold is same to old");
        address oldAddr = ntfTokenSoldAddr;
        ntfTokenSoldAddr = _ntfTokenSoldAddr;
        nftTokenSold = NftTokenSold(_ntfTokenSoldAddr);
        emit NtfTokenSoldChanged(oldAddr, _ntfTokenSoldAddr);
    }

    /**
     * @dev Offers on the token, replacing the offer if the offer is higher than the current offer.
     * You cannot offer on a token you already own.
     * Check:
     * - Token Owner can't offer
     * - msg.value must be greater than offer value * 1.03
     * - new offer value must be greater than old offer value
     * state change:
     * - tokenOfferer[], tokenCurrentOffer[]
     * call:
     * - return old offer if available
     * - emit event
     * @param _tokenId uint256 ID of the token to offer on
     * @param _value uint256 new offer value
     */
    function offer(uint256 _tokenId, uint256 _value) external payable _notOwnerOf(ozerc721, _tokenId) _payValueValid(_value) {
        require(msg.value > offers[_tokenId].offerValue, "NtfAuction: new Offer must be greater than old");

        if(offers[_tokenId].offerValue > 0 ){ // have old offer
            uint256 oldPayValue = offers[_tokenId].payValue;
            address oldOfferer = offers[_tokenId].offerer;
            if(oldOfferer != address(0) && oldPayValue > 0) {
                payable(oldOfferer).transfer(oldPayValue);
                emit Payoff(oldOfferer,  oldPayValue);
            }
            offers[_tokenId].offerer = _msgSender();
            offers[_tokenId].offerValue = _value;
            offers[_tokenId].payValue = msg.value;
        } else { // first offer
            offers[_tokenId] = OfferItem({offerer: _msgSender(), offerValue: _value, payValue: msg.value});
        }
        emit Offer(ozerc721Addr, _msgSender(), _tokenId, _value);
    }

    /**
     * @dev Cancels the offer on the token, returning the offer amount to the offerer.
     * check:
     * - only current offerer can be cancel
     * state change:
     * - delete offers[]
     * call:
     * - return value
     * - emit event
     * @param _tokenId uint256 ID of the token with an offer
     */
    function cancelOffer(uint256 _tokenId) external {
        address offerer = offers[_tokenId].offerer;
        require(_msgSender() == offerer, "NtfAuction: must be origin offerer");
        uint256 returnValue = offers[_tokenId].payValue;
        uint256 offerValue = offers[_tokenId].offerValue;
        if(offerer != address(0) && returnValue > 0) {
            payable(offerer).transfer(returnValue);
            emit Payoff(offerer,  returnValue);
        }
        delete offers[_tokenId];

        emit CancelOffer(ozerc721Addr, offerer, _tokenId, offerValue);
    }


    /**
     * @dev Accept the offer on the token, transferring ownership to the current offerer and paying out the owner.
     * check:
     * - owner, operator, approver can accept
     * - must have offer
     * - not in auction
     * state change:
     * - delete offers[]
     * - delete tokenSalePrice[]
     * call:
     * - transfer
     * - payoff
     * @param _tokenId uint256 ID of the token with the standing offer
     */
    function acceptOffer(uint256 _tokenId) external _onlyTokenApprover1(ozerc721, _tokenId) {
        require(offers[_tokenId].offerValue > 0, "NftAuction: must have offer");
        require(auctionType[_tokenId] == AuctionType.None, "NftAuction: must not in auction");

        address offerer = offers[_tokenId].offerer;
        uint256 offerValue = offers[_tokenId].offerValue;
        uint256 payValue = offers[_tokenId].payValue;
        address tokenOwner = ozerc721.ownerOf(_tokenId);
        address creator = ozerc721.tokenCreator(_tokenId);

        delete offers[_tokenId];
        if(tokenSalePrice[_tokenId] > 0){
            delete tokenSalePrice[_tokenId];
        }

        ozerc721.safeTransferFrom(tokenOwner, offerer, _tokenId);
        payout(payValue, offerValue, owner(), creator, tokenOwner, _tokenId);
        emit AcceptOffer(ozerc721Addr, offerer, tokenOwner, offerValue, _tokenId);
    }

    /**
     * @dev Set the sale price of the token
     * check:
     * - tokenOwner, approver, operator can do
     * - greater than current offer
     * - not in auction
     * state change:
     * - tokenSalePrice[]
     * call:
     * - emit
     * @param _tokenId uint256 ID of the token with the standing offer
     */
    function setSalePrice(uint256 _tokenId, uint256 _salePrice) external _onlyTokenApprover1(ozerc721, _tokenId) {
        uint256 currentOffer = offers[_tokenId].offerValue;
        require(_salePrice > currentOffer, "NftAuction: sale price must greater than current offer");
        require(auctionType[_tokenId] == AuctionType.None, "NftAuction: must not in auction");
        tokenSalePrice[_tokenId] = _salePrice;
        SalePriceSet(ozerc721Addr,  _tokenId, _salePrice);
    }

    /**
     * @dev Purchase the token if there is a sale price;
     * transfers ownership to buyer and pays out owner.
     * check:
     * - not owner
     * - not in auction
     * - must have sale price
     * - payValue must be greater than price * 1.03
     * state changed:
     * - delete tokenSalePrice
     * - delete offers
     * call:
     * - transfer
     * - payoff
     * - return offer
     * @param _tokenId uint256 ID of the token to be purchased
     */
    function buy(uint256 _tokenId) public payable _notOwnerOf(ozerc721, _tokenId) {
        require(auctionType[_tokenId] == AuctionType.None, "NftAuction: must not in auction");
        uint256 salePrice = tokenSalePrice[_tokenId];
        require(salePrice > 0, "NftAuction: Token must have sale price");
        uint256 minPayValue = salePrice + (salePrice * maintainerTransPer / 1000);
        uint256 sentPrice = msg.value;
        require(minPayValue > salePrice && sentPrice >= minPayValue, "NftAuction: payValue must be greater than _value");

        address buyer = _msgSender();
        address tokenOwner = ozerc721.ownerOf(_tokenId);
        address creator = ozerc721.tokenCreator(_tokenId);
        address currentOfferer = offers[_tokenId].offerer;
        uint256 returnValue = offers[_tokenId].payValue;
        if(currentOfferer != address(0) && returnValue > 0) {
            delete offers[_tokenId];
            payable(currentOfferer).transfer(returnValue);
            emit Payoff(currentOfferer,  returnValue);
        }
        delete tokenSalePrice[_tokenId];

        ozerc721.safeTransferFrom(tokenOwner, buyer, _tokenId);
        payout(sentPrice, salePrice, owner(), creator, tokenOwner, _tokenId);

        Buy(ozerc721Addr, buyer, tokenOwner, salePrice, _tokenId);
    }

    /**
     * @dev create a schedule auction, which has start-time and finish-time. start price can be zero.
     * 检查：
     * 1. 只有Owner，Operator和Approver才能操作
     * 2. 确认auctionType里没有
     * 3. start block要1分钟以后，即比当前block的number多5个
     * 4. 持续时间必须要15分钟以上，即大于69个出块数量
     * 修改状态：
     * 5. origOwner添加tokenId的当前owner
     * 6. auctionType添加Schedule类型
     * 7. sAuctions添加对应价格，起始块号，持续块数
     * 外部调用：
     * 8. NFT将tokenId转移到本合约地址
     * 9. emit event
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
        require(_startBlock>block.number+5 && _startBlock<block.number+2425847, "NftAuction: startTime must be 1 min later and within 1 year");
        require(_durBlocks>70 && _durBlocks<206032, "NftAuction: Schedule auction must last at least 15 mins and less than 31 days");
        origOwner[_tokenId] = ozerc721.ownerOf(_tokenId);
        auctionType[_tokenId] = AuctionType.Schedule;
        sAuctions[_tokenId] = SAuction({startPrice:_startPrice, startBlock:_startBlock, durBlocks:_durBlocks});
        //ozerc721.safeTransferFrom(ozerc721.ownerOf(_tokenId), address(this), _tokenId); //TODO
        //TODO: emit ScheduleAuction(ozerc721Addr, _tokenId, ozerc721.ownerOf(_tokenId), _startPrice, _startBlock, _durBlocks);
    }

    /**
     * @dev create a reserve auction, which has a start price. when a bid is reached, a 24 hours auction is started automatically.
     * 检查：
     * 1. 只有Owner，Operator和Approver才能操作
     * 2. 确认auctionType里没有
     * 3. startPrice要大于0
     * 4. 持续时间必须要15分钟以上，即大于69个出块数量
     * 修改状态：
     * 5. auctionType添加Reserve类型
     * 6. rAuctions添加对应价格，持续块数
     * 外部调用：
     * 7. emit event
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
        require(_durBlocks>70 && _durBlocks<206032, "NftAuction: Schedule auction must last at least 15 mins and less than 31 days");
        auctionType[_tokenId] = AuctionType.Reserve;
        rAuctions[_tokenId] = RAuction({startPrice:_startPrice, durBlocks:_durBlocks});
        //TODO: emit ReserveAuction(ozerc721Addr, _tokenId, ozerc721.ownerOf(_tokenId), _startPrice, _durBlocks);
    }


    /**
     * @dev cancel an auction before it starts.
     * 检查：
     * 1. 只有Owner(对于schedule auction而言，原Owner)，Operator和Approver才能操作
     * 2. 确认auctionType里有
     * 3. 对于reserve auction，检查是否已经开始（有bid了），确保没有
     * 4. 对于Schedule auction，检查是否已经开始（当前block number 大于等于 startBlock），确保没有
     * 修改状态：
     * 5. 对于reserve auction：删除rAuctions，auctionType
     * 6. 对于schedule auction：删除sAuctions，originOwner，auctionType
     * 外部调用：
     * 8. 对于schedule auction：将tokenId还给原来的originOwner
     * 9.
     *
     * Requirements:
     * - `_tokenId` must exist.
     */
    //    function cancelAuction(uint256 _tokenId) _onlyTokenApprover(ozerc721, _tokenId) external {
    function cancelAuction(uint256 _tokenId) external {
        AuctionType aType = auctionType[_tokenId];
        require(aType != AuctionType.None, "NftAuction: tokenId should been in auction");
        if(aType == AuctionType.Reserve){
            require(biddingAuctions[_tokenId].startBlock != 0,"NftAuction: reserve auction already start");
            delete rAuctions[_tokenId];
        }else{ // AuctionType.Schedule
            require(block.number < sAuctions[_tokenId].startBlock, "NftAuction: schedule auction already start");
            ozerc721.safeTransferFrom(address(this), origOwner[_tokenId], _tokenId);
            delete origOwner[_tokenId];
            delete sAuctions[_tokenId];
        }
        delete auctionType[_tokenId];
        //TODO: emit CancelAuction(ozerc721Addr, _tokenId, _msgSender());
    }

    /**
     * @dev bid a token in an auction with value. the payed value is 1.03 times of bid _value.
     * 检查：
     * 1. owner(auction的原owner)， operator，approver 不能bid
     * 2. auctionType里有
     * 3. 时间检查：
     *   3.1 对于R，biddingAuctions里的startblock，以及start+durBlocks
     *   3.2 对于S，如果biddingAuction里有，则判断start block和durblocks；如果biddingAuctions里没有，则判断sAuctions里的start block和durblocks
     * 4. value检查
     *   4.1 pay value是_value的1.03倍及以上
     *   4.2 如果biddingAuction里有，则value大于之前的；如果biddingAuction没有，则value大于startPrice
     * 修改状态
     * 5. 对于R：
     *   5.1 如果biddingAuction里有，则更新currentBid和currentBidder；如果当前block距离结束block小于70个（15分钟），则计算新的durBlocks(当前block+70-startBlock）；
     *   5.2 如果biddingAuction里无，则添加到biddingAuction里；添加origOwner
     * 6. 对于S：
     *   6.1 如果biddingAuction里有，则更新currentBid和currentBidder；如果当前block距离结束block小于70个（15分钟），则计算新的durBlocks(当前block+70-startBlock）；
     *   6.2 如果biddingAuction里无，则添加到biddingAuction里
     * 外部调用：
     * 7. 对于R：如果是第一次bid，则transfer nft token到本合约地址
     * 8. 对于所有：return old bid
     * Requirements:
     * - `_tokenId` must exist.
     * - `_value` must bid value.
     */
    //    function bid(uint256 _tokenId, uint256 _value) _notTokenApprover(ozerc721, _tokenId) external payable {
    function bid(uint256 _tokenId, uint256 _value) external payable {
        AuctionType aType = auctionType[_tokenId];
        require(aType != AuctionType.None, "NftAuction: tokenId should been in auction");
        uint256 minPayValue = _value + (_value * maintainerTransPer / 1000);
        require(minPayValue > _value && msg.value >= minPayValue, "NftAuction: payValue must be greater than _value");

        if(biddingAuctions[_tokenId].startBlock != 0){
            uint256 oldDurBlocks = biddingAuctions[_tokenId].durBlocks;
            uint256 oldEndBlock = biddingAuctions[_tokenId].startBlock + oldDurBlocks;
            uint256 oldBid = biddingAuctions[_tokenId].currentBid;
            address oldBidder = biddingAuctions[_tokenId].currentBidder;
            uint256 oldPayValue = biddingAuctions[_tokenId].payValue;
            uint256 newDurBlocks = 0;

            require(block.number <= oldEndBlock, "NftAuction: auction time out");
            require(_value > oldBid, "NftAuction: new bidder must be bigger");
            biddingAuctions[_tokenId].currentBid = _value;
            biddingAuctions[_tokenId].currentBidder = _msgSender();
            biddingAuctions[_tokenId].payValue = msg.value;
            if(block.number + 70 > oldEndBlock){
                newDurBlocks = block.number + 70 - biddingAuctions[_tokenId].startBlock;
                biddingAuctions[_tokenId].durBlocks = newDurBlocks;
            }
            payable(oldBidder).transfer(oldPayValue);

            emit Payoff(oldBidder,  oldPayValue);
            emit Bid(ozerc721Addr, _tokenId, _msgSender(), _value, oldBidder, newDurBlocks, false);
        } else {
            uint256 newDurBlocks = 0;
            if(aType == AuctionType.Schedule){
                require(block.number >= sAuctions[_tokenId].startBlock ,"NftAuction: schedule auction not start");
                require(block.number <= sAuctions[_tokenId].startBlock + sAuctions[_tokenId].durBlocks,"NftAuction: schedule auction finished");
                require(_value>=sAuctions[_tokenId].startPrice,"NftAuction: value too small");
                newDurBlocks = sAuctions[_tokenId].durBlocks;
                if(block.number + 70 > sAuctions[_tokenId].startBlock + sAuctions[_tokenId].durBlocks){
                    newDurBlocks = block.number + 70 - sAuctions[_tokenId].startBlock;
                }
                biddingAuctions[_tokenId] = BiddingAuction({startBlock:sAuctions[_tokenId].startBlock,
                durBlocks:newDurBlocks,
                currentBid:_value,
                currentBidder:payable(_msgSender()),
                payValue:msg.value});

            } else {
                require(_value>=rAuctions[_tokenId].startPrice,"NftAuction: value too small");
                newDurBlocks = rAuctions[_tokenId].durBlocks;
                biddingAuctions[_tokenId] = BiddingAuction({startBlock:block.number,
                durBlocks:newDurBlocks,
                currentBid:_value,
                currentBidder:payable(_msgSender()),
                payValue:msg.value});
                origOwner[_tokenId] = ozerc721.ownerOf(_tokenId);
                ozerc721.safeTransferFrom(ozerc721.ownerOf(_tokenId), address(this), _tokenId);
            }
            emit Bid(ozerc721Addr, _tokenId, _msgSender(), _value, address(0), newDurBlocks, true);
        }
    }

    /**
     * @dev settle a finished auction. payout the values.
     * 检查：
     * 1. auctionType存在
     * 2. 原Owner，approver，operator，现owner，buyer
     * 3. 如果BiddingAuction存在，判断endblock完结
     * 4. 如果BiddingAuction不存在
     *    4.1 对于RAuction报错；
     *    4.2 对于SAuction，判断endBlock完结
     * 修改状态：
     * 5. 如果有bidding，delete buddingAuction
     * 6. delete origOwner, rAuctions|sAuctions, auctionType
     * 外部调用
     * 7. nft transfer to buyer|originOwner
     * 8. pay
     * 9. emit event
     * Requirements:
     * - `_tokenId` must exist.
     */
    function settleAuction(uint256 _tokenId) external {
        AuctionType aType = auctionType[_tokenId];
        require(aType != AuctionType.None, "NftAuction: tokenId should been in auction");
        if(biddingAuctions[_tokenId].startBlock != 0){
            require(block.number > biddingAuctions[_tokenId].startBlock + biddingAuctions[_tokenId].durBlocks, "NftAuction: auction not finish");
            address sender = _msgSender();
            require(origOwner[_tokenId] != address(0), "NftAuction: origOwner must have value");
            require(ozerc721.ownerOf(_tokenId) == sender
            || ozerc721.getApproved(_tokenId) == sender
            || origOwner[_tokenId] == sender
            || ozerc721.isApprovedForAll(origOwner[_tokenId], sender)
                || biddingAuctions[_tokenId].currentBidder == sender,
                "NftAuction: operator is not approved");

            uint256 payValue = biddingAuctions[_tokenId].payValue;
            uint256 currentBid = biddingAuctions[_tokenId].currentBid;
            address tokenOwner = origOwner[_tokenId];
            address winner = biddingAuctions[_tokenId].currentBidder;

            delete origOwner[_tokenId];
            delete biddingAuctions[_tokenId];
            if(aType == AuctionType.Reserve){
                delete rAuctions[_tokenId];
            } else {
                delete sAuctions[_tokenId];
            }
            delete auctionType[_tokenId];

            payout(payValue, currentBid, owner(), ozerc721.tokenCreator(_tokenId), tokenOwner, _tokenId);
            ozerc721.safeTransferFrom(address(this), winner, _tokenId);

            emit SettleAuction(ozerc721Addr, _tokenId, winner, tokenOwner, currentBid);
        } else { // auction has not bidding
            if(aType == AuctionType.Reserve){
                revert("NftAuction revert: Reserve auction not start");
            }

            address sender = _msgSender();
            require(ozerc721.ownerOf(_tokenId) == sender
            || ozerc721.getApproved(_tokenId) == sender
            || origOwner[_tokenId] == sender
                || ozerc721.isApprovedForAll(origOwner[_tokenId], sender),
                "NftAuction: operator is not approved");
            require(block.number > sAuctions[_tokenId].startBlock + sAuctions[_tokenId].durBlocks, "NftAuction: schedule auction not finish");

            address tokenOwner = origOwner[_tokenId];
            require(tokenOwner != address(0), "NftAuction: origOwner must have value");

            delete origOwner[_tokenId];
            delete sAuctions[_tokenId];
            delete auctionType[_tokenId];

            ozerc721.safeTransferFrom(address(this), tokenOwner, _tokenId);

            emit SettleAuction(ozerc721Addr, _tokenId, tokenOwner, tokenOwner, 0);
        }
    }

    /**
     * pay money to participants.
     * TODO: should set token sold to true
     */
    function payout(uint256 _payVal, uint256 _val, address _maintainerAddr, address _creatorAddr, address _tokenOwner, uint256 _tokenId) private {
        uint256 maintainerTransPayment = _payVal - _val;
        uint256 handlingFee;
        uint256 ownerPayment;
        address handFeeAddr;

        //Sold before, creator hava 10%
        if(nftTokenSold.getTokenSold(_tokenId)){
            handlingFee = _val * secondHandFeePer / 1000;
            handFeeAddr = _creatorAddr;
        } else {
            handlingFee = _val * firstHandFeePer / 1000;
            handFeeAddr = _maintainerAddr;
            nftTokenSold.setTokenSold(_tokenId);
        }
        ownerPayment = _val - handlingFee;

        (payable(_maintainerAddr)).transfer(maintainerTransPayment);
        emit Payoff(_maintainerAddr,  maintainerTransPayment);
        (payable(handFeeAddr)).transfer(handlingFee);
        emit Payoff(handFeeAddr, handlingFee);
        (payable(_tokenOwner)).transfer(ownerPayment);
        emit Payoff(_tokenOwner,  ownerPayment);
    }

}
