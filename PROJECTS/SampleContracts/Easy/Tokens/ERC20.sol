// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

interface IERC20 {
    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

contract LoekerToken is IERC20 {
    string public constant name = "Loeker";
    string public constant symbol = "LKR";
    uint8 public constant decimals = 18;

    uint256 private _totalSupply;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    constructor() {
        _totalSupply = 1_000_000 * 10**uint256(decimals);
        _balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account)
        external
        view
        override
        returns (uint256)
    {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount)
        external
        override
        returns (bool)
    {
        require(recipient != address(0), "ERC20: transfer to zero address");
        require(_balances[msg.sender] >= amount, "ERC20: insufficient balance");

        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;

        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender)
        external
        view
        override
        returns (uint256)
    {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount)
        external
        override
        returns (bool)
    {
        require(spender != address(0), "ERC20: approve to zero address");

        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);

        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external override returns (bool) {
        require(
            sender != address(0),
            "ERC20: transferFrom sender zero address"
        );
        require(
            recipient != address(0),
            "ERC20: transferFrom recipient zero address"
        );
        require(_balances[sender] >= amount, "ERC20: insufficient balance");
        require(
            _allowances[sender][msg.sender] >= amount,
            "ERC20: allowance exceeded"
        );

        _balances[sender] -= amount;
        _balances[recipient] += amount;

        _allowances[sender][msg.sender] -= amount;

        emit Transfer(sender, recipient, amount);
        emit Approval(sender, msg.sender, _allowances[sender][msg.sender]); // optional: to reflect updated allowance

        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue)
        external
        returns (bool)
    {
        require(
            spender != address(0),
            "ERC20: increaseAllowance to zero address"
        );

        _allowances[msg.sender][spender] += addedValue;
        emit Approval(msg.sender, spender, _allowances[msg.sender][spender]);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue)
        external
        returns (bool)
    {
        require(
            spender != address(0),
            "ERC20: decreaseAllowance to zero address"
        );
        require(
            _allowances[msg.sender][spender] >= subtractedValue,
            "ERC20: decreased allowance below zero"
        );

        _allowances[msg.sender][spender] -= subtractedValue;
        emit Approval(msg.sender, spender, _allowances[msg.sender][spender]);
        return true;
    }
}



