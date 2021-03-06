// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


// CAUTION
// This version of SafeMath should only be used with Solidity 0.8 or later,
// because it relies on the compiler's built in overflow checks.

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly { size := extcodesize(account) }
        return size > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{ value: value }(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data, string memory errorMessage) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.staticcall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    function _verifyCallResult(bool success, bytes memory returndata, string memory errorMessage) private pure returns(bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}


/**
 * @dev Wrappers over Solidity's arithmetic operations.
 *
 * NOTE: `SafeMath` is no longer needed starting with Solidity 0.8. The compiler
 * now has built in overflow checking.
 */
library SafeMath {

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
    using Address for address;

    IOZERC721 private ozerc721;
    address private ozerc721Addr;

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
        ozerc721Addr = _ozerc721;
        ozerc721 = IOZERC721(_ozerc721);
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
        ozerc721.safeTransferFrom(tokenOwner, currentOfferer, _tokenId); //?????????delegatecall????????????????????????approve???

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
     * TODO???test
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
