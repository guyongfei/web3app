// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


// CAUTION
// This version of SafeMath should only be used with Solidity 0.8 or later,
// because it relies on the compiler's built in overflow checks.

/**
 * @dev Wrappers over Solidity's arithmetic operations.
 *
 * NOTE: `SafeMath` is no longer needed starting with Solidity 0.8. The compiler
 * now has built in overflow checking.
 */
 library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
     function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the substraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
     function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
     function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
     function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
     function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
     function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
     function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
     function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
     function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
     function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
     function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
     function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
     function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
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

contract NftTrans is Ownable{
    using SafeMath for uint256;
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
        require(_ozerc721.ownerOf(_tokenId) != _msgSender(), "NftTrans: must not be token owner");
        _;
    }

    /**
     * @dev Guarantees msg.sender is the owner of the given token
     * @param _tokenId uint256 ID of the token to validate its ownership belongs to msg.sender
     */
     modifier onlyOwnerOf(IOZERC721 _ozerc721, uint256 _tokenId) {
        require(_ozerc721.ownerOf(_tokenId) == _msgSender(), "NftTrans: must be token owner");
        _;
    }

    constructor(address _ozerc721) {
        ozerc721 = IOZERC721(_ozerc721);
    }

    /**
     * TODO: test method to getNftName
     */
     function getNftName() external view returns (string memory){
        return ozerc721.name();
    }

    function setNtfAddr(address _newNftAddr) onlyOwner external {
        ozerc721 = IOZERC721(_newNftAddr);
    }

    /**
     * @dev Offers on the token, replacing the offer if the offer is higher than the current offer. 
     * You cannot offer on a token you already own.
     * @param _tokenId uint256 ID of the token to offer on
     */
     function offer(uint256 _tokenId) external payable notOwnerOf(ozerc721, _tokenId) {
        require(isGreaterOffer(_tokenId), "NftTrans: new Offer must greater than old");
        returnCurrentOffer(_tokenId);
        tokenOfferer[_tokenId] = payable(_msgSender());
        tokenCurrentOffer[_tokenId] = msg.value;
        emit Offer(msg.sender, msg.value, _tokenId);
    }

    /**
     * @dev Cancels the offer on the token, returning the offer amount to the offerer.
     * @param _tokenId uint256 ID of the token with an offer
     */
     function cancelOffer(uint256 _tokenId) public {
        address payable Offerer = tokenOfferer[_tokenId];
        require(_msgSender() == Offerer, "NftTrans: must be origin offerer");
        uint256 offerAmount = tokenCurrentOffer[_tokenId];
        Offerer.transfer(offerAmount);
        clearOffer(_tokenId);
        CancelOffer(Offerer, offerAmount, _tokenId);
    }

    /**
     * @dev Accept the offer on the token, transferring ownership to the current offerer and paying out the owner.
     * @param _tokenId uint256 ID of the token with the standing offer
     */
     function acceptOffer(uint256 _tokenId) public onlyOwnerOf(ozerc721, _tokenId) {
        uint256 currentOffer = tokenCurrentOffer[_tokenId];
        address currentOfferer = tokenOfferer[_tokenId];
        address tokenOwner = ozerc721.ownerOf(_tokenId);
        address creator = ozerc721.tokenCreator(_tokenId);
        ozerc721.safeTransferFrom(tokenOwner, currentOfferer, _tokenId);
        payout(currentOffer, owner(), creator, tokenOwner, _tokenId);
        clearOffer(_tokenId);
        AcceptOffer(currentOfferer, tokenOwner, currentOffer, _tokenId);
        tokenSalePrice[_tokenId] = 0;
    }

    /**
     * @dev Set the sale price of the token
     * @param _tokenId uint256 ID of the token with the standing offer
     */
     function setSalePrice(uint256 _tokenId, uint256 _salePrice) public onlyOwnerOf(ozerc721, _tokenId) {
        uint256 currentOffer = tokenCurrentOffer[_tokenId];
        require(_salePrice > currentOffer);
        tokenSalePrice[_tokenId] = _salePrice;
        SalePriceSet(_tokenId, _salePrice);
    }

    /**
     * @dev Gets the sale price of the token
     * @param _tokenId uint256 ID of the token
     * @return sale price of the token
     */
     function salePriceOfToken(uint256 _tokenId) public view returns (uint256) {
        return tokenSalePrice[_tokenId];
    }


    /**
     * @dev Purchase the token if there is a sale price; 
     * transfers ownership to buyer and pays out owner.
     * @param _tokenId uint256 ID of the token to be purchased
     */
     function buy(uint256 _tokenId) public payable notOwnerOf(ozerc721, _tokenId) {
        uint256 salePrice = tokenSalePrice[_tokenId];
        uint256 sentPrice = msg.value;
        address buyer = _msgSender();
        address tokenOwner = ozerc721.ownerOf(_tokenId);
        address creator = ozerc721.tokenCreator(_tokenId);
        require(salePrice > 0, "NftTrans: Token must have sale price");
        require(sentPrice >= salePrice, "NftTrans: buyer price must bigger sale price");
        returnCurrentOffer(_tokenId);
        clearOffer(_tokenId);
        ozerc721.safeTransferFrom(tokenOwner, buyer, _tokenId);
        payout(sentPrice, owner(), creator, tokenOwner, _tokenId);
        tokenSalePrice[_tokenId] = 0;
        Sold(buyer, tokenOwner, sentPrice, _tokenId);
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
     * TODO：test
     */
     function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    /**
     * @dev Internal function to clear offer
     * @param _tokenId uint256 ID of the token with the standing offer
     */
     function clearOffer(uint256 _tokenId) private {
    //        tokenOfferer[_tokenId] = address(0);
    //        tokenCurrentOffer[_tokenId] = 0;
    delete tokenOfferer[_tokenId];
    delete tokenCurrentOffer[_tokenId];
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

    /**
    * @dev Internal function to pay the offerer, creator, and maintainer
    * @param _val uint256 value to be split
    * @param _maintainer address of account maintaining SupeRare
    * @param _creator address of the creator of token
    * @param _maintainer address of the owner of token
    */
    function payout(uint256 _val, address _maintainer, address _creator, address _tokenOwner, uint256 _tokenId) private {
        uint256 maintainerPayment;
        uint256 creatorPayment;
        uint256 ownerPayment;
        if (tokenSold[_tokenId]) {
            maintainerPayment = _val.mul(maintainerPercentage).div(1000);
            creatorPayment = _val.mul(creatorPercentage).div(1000);
            ownerPayment = _val.sub(creatorPayment).sub(maintainerPayment);
        } else {
            maintainerPayment = 0;
            creatorPayment = _val;
            ownerPayment = 0;
            tokenSold[_tokenId] = true;
        }
        (payable(_maintainer)).transfer(maintainerPayment);
        (payable(_creator)).transfer(creatorPayment);
        (payable(_tokenOwner)).transfer(ownerPayment);

    }
}