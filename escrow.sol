pragma solidity ^0.8.4;

contract escrow{
    address admin;

    mapping(address => uint256) public deposits;

    modifier confirmAdmin(){
        require(msg.sender == admin);
        _;
    }

    constructor () public{
        admin = msg.sender;
    }
    function deposit (address payee) public confirmAdmin payable{
        uint256 amount = msg.value;
        deposits[payee] = deposits[payee] + amount;
    }
    function withdraw (address payable payee) confirmAdmin public{
        uint256 payment = deposits[payee];
        deposits[payee] = 0;
        payee.transfer(payment);
    }
}