// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @dev Defines Interface of ERC20 standard
 */
interface IERC20 {
    
    /**
     * @dev Returns the total tokens that exist
     */
    function totalSupply() external view returns(uint256);
    
    /**
     * @dev Returns the amount of tokens owned by a particular address
     */
    function balanceOf(address tokenOwner) external view returns(uint256);

    /**
     * @dev transfer a number of tokens from the caller address to receiver
     *
     * Returns a boolean value to show whether or not the transfer was successful
     *
     * Emits a {Transfer} event.
     */
    function transfer(address receiver, uint256 numOfTokens) external returns (bool);
    
    /**
     * @dev Returns the remaining nunber of tokens that `delegate` is allowed to use.
     *
     * The delegate use the allowance through {transferFrom} function. 
     *
     * This value is zero by defaul and changes when {approve} or {transferFrom} is called.
     */
    function allowance(address owner, address delegate) external view returns (uint256);

    /**
     * @dev Sets `numOfTokens` as the allowance of `delegate` from the caller's tokens.
     *
     * Returns a boolean value to indicate whether or not the approval was successful
     *
     * Emits an {Approval} event
     */
    function approve(address delegate, uint256 numOfTokens) external returns (bool);

    /**
     * @dev Transfers a `numberOfTokens` from `owner` to `receiver` 
     * usin the allowance mechanism.
     *
     * `numOfTokens` is then debited from `owner` allowance
     *
     * Returns a boolean to indicate whether or not the transfer was successful
     *
     * Emits a {Transfer} event
     */
    function transferFrom(address owner, address receiver, uint256 numOfTokens) external returns (bool);

    /**
     * @dev Gets the name of the token
     */
    function name() external view returns (string memory);

    /**
     * @dev Gets the symbol of the token
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Gets the decimal places of the token
     */
    function decimals() external view returns (uint8);

    /**
     * @dev Emitted when `numOfTokens` of tokens are transferred from `owner` account to `receiver` account
     */
    event Transfer(address indexed owner, address indexed receiver, uint256 numOfTokens);

    /**
     * @dev Emitted when the allowance of a `delegate` for a token `owner` is set 
     * by a call to {approve}. `numOfTokens` becomes the new allowance
     */
    event Approval(address indexed owner, address indexed delegate, uint256 numOfTokens);
  
}