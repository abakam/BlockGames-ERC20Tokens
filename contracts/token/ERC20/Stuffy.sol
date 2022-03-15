// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC20.sol";


/**
 * @dev Implements the {IERC20} interface
 */
contract Stuffy is IERC20 {
    address public founder;

    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * @dev Sets the token name and symbol
     * @param name_ the name of the token
     * @param symbol_ the symbol of the token
     * @param totalSupply_ the total amount of the token in supply
     */
    constructor(string memory name_, string memory symbol_, uint256 totalSupply_) {
        _name = name_;
        _symbol = symbol_;
        _totalSupply = totalSupply_;
        founder = msg.sender;
        _balances[founder] = _totalSupply;
    }

    /**
     * @dev Returns the name of the token
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` is `2`, a balance of 108 tokens would be 
     * displayed to the user as `1.08` (108 / 10^2)
     * 
     * We would use decimal 18 to immitate Ether and Wei
     */
    function decimals() public view virtual override returns (uint8) {
        return 2;
    }

    /**
     * @dev see {IERC20-totalSupply}
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}
     */
    function balanceOf(address tokenOwner) public view virtual override returns (uint256) {
        return _balances[tokenOwner];
    }

    /**
     * @dev See {IERC20-transfer}
     * @param receiver of tokens
     * @param numOfTokens the number of tokens to be transferred
     * @notice transfer would be called from owner's account
     */
    function transfer(address receiver, uint256 numOfTokens) public virtual override returns (bool) {
        address owner = msg.sender;

        require(owner != address(0), "cannot transfer from the zero address");
        require(receiver != address(0), "cannot transfer to the zero address");

        uint256 ownerBalance = _balances[owner];
        require(ownerBalance >= numOfTokens, "Number of tokens to transfer exceeds balance");
        unchecked {
            _balances[owner] = ownerBalance - numOfTokens;
        }
        _balances[receiver] += numOfTokens;

        emit Transfer(owner, receiver, numOfTokens);

        return true;

    }

    /**
     * @dev See {IERC20-allowance}
     * @param owner the account that owns the tokens
     * @param delegate the account that is given permission to use some of the tokens
     */
    function allowance(address owner, address delegate) public view virtual override returns(uint256) {
        return _allowances[owner][delegate];
    }

    /**
     * @dev See {IERC20-approve}
     * @param delegate an account that is permitted to use tokens on behalf of an owner
     * @param numOfTokens the amount of tokens a delegate is allowed to use
     * @notice approve would be called from owner's account
     */
    function approve(address delegate, uint256 numOfTokens) public virtual override returns(bool) {
        address owner = msg.sender;

        require(owner != address(0), "cannot approve from the zero address");
        require(delegate != address(0), "cannot delegate to the zero address");

        _allowances[owner][delegate] = numOfTokens;

        emit Approval(owner, delegate, numOfTokens);

        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}
     * @param owner the account to transfer the token from
     * @param receiver the accout that the token is transferred to
     * @param numOfTokens the number of tokens to be transferred
     * @notice transferFrom would be called from the delegate's account
     */
    function transferFrom(address owner, address receiver, uint256 numOfTokens) public virtual override returns (bool){
        address delegate = msg.sender;  // the account that is allowed to use the tokens on behalf of the owner

        uint256 currentAllowance = allowance(owner, delegate);

        if(currentAllowance != type(uint256).max) {
            require(currentAllowance >= numOfTokens, "amount of tokens to transfer exceeds allowance");
            unchecked {
                 _allowances[owner][delegate] -= numOfTokens;
            }
        }
        
        require(_balances[owner] >= numOfTokens, "amount of tokens to transfer exceeds owner balance");

        _balances[owner] -= numOfTokens;
        _balances[receiver] += numOfTokens;
       
        emit Transfer(owner, receiver, numOfTokens);

        return true;
    }
    
}