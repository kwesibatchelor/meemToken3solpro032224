// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

contract RobustToken {
    // define public and private variables 
    // such as admin name symbol token supply
    address public admin;

    string private _name = "Robust Token";
    string private _symbol = "RT";
    uint256 private _totalSupply = 10000 * 10 **18;

    // define 2 events: transfer & approval (emmited after some functions)
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed from, address indexed to, uint256 value);

    // keep track of balances and allowances (ie approvals)
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    // define who the admin is and initialize admin to receive all the tokens 
    constructor() {
        admin = msg.sender;
        _balances[msg.sender] = _totalSupply;
    }

    // transfer function 
    //moves tokens from callers account to recipients account 
    function transfer(address to, uint256 value) public returns (bool) {
        require(_balances[msg.sender] >= value);
        _balances[msg.sender] -= value;
        _balances[to] += value;
        emit Transfer(msg.sender, to, value);
        return true; // return true or false to let user know if transfer was succesful
    }

    // transfer from function (similar to transfer function
    // spender can be a 3rd party the user has given approval to
    function transferFrom(address from, address to, uint256 value) public returns(bool) {
        require(_balances[from] >= value && _allowances[from][msg.sender] >= value);
        _allowances[from][msg.sender] -= value;
        _balances[from] -= value;
        _balances[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    // approve function
    function approve(address spender, uint256 value) public returns (bool) {
        require(spender != msg.sender);
        _allowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    // allowance function
    // returns the amount of tokens that the spender can spend
    function allowance(address owner, address spender) public view returns(uint256) {
        return _allowances[owner][spender];
    }

    function balanceOf(address owner) public view returns(uint256) {
        return _balances[owner];
    }

    function totalSupply() public view returns(uint256) {
        return _totalSupply;
    }

    function name() public view returns(string memory) {
        return _name;
    }

    function symbol() public view returns(string memory) {
        return _symbol;
    }

    function decimals() public pure returns(uint8) {
        return 18;
    }
}
