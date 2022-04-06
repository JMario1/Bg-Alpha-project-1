//SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

import "hardhat/console.sol";
import "./Nestcoin.sol";


contract Nxt {
    NestCoin public nestcoin;

    event Payment(address indexed payer, uint amount, string indexed ref);

    constructor(address tokenAddr) {
        nestcoin = NestCoin(tokenAddr);
    }

    function batchTokenTransfer(address owner, address[] memory _userAddr,  uint256[] memory _amount) public  {
        require(_userAddr.length == _amount.length, "Number of Addresses must match amount");
        for (uint256 i = 0; i < _userAddr.length; i++) {
            transferFrom(owner, _userAddr[i], _amount[i]);
        }
    }

    // with a ref, every payment is traceable to the value provided
    function pay(uint amountOfTokens, string ref) public {


        // Transfer token
        nestcoin.transferFrom(msg.sender, address(this), amountOfTokens);

        // Emit Pay event
        emit Payment(msg.sender, amountOfTokens, ref);

    }

    function triggerMint() public onlyOwner {
        nestCoin.mint(_msgSender(), amount);
    }

    function burn(uint256 amount) public {
        _burn(_msgSender(), amount);
    }
}

