// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title BalanceManager
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 * 基本符合ERC20规范的智能合约，形式上就可以表达一种资产，一种token，这种token能够用metamask钱包来进行操作
 * Sepolia-Account1: 0x9fB0CDD6C5138E146aA3f0215cff57A263B45670
 * Sepolia-Account1 部署后的合约地址：0x10595f535558287d77329171c875EFc0E563e834
 * Sepolia-Account2: 0x25D0b43D15e355aFF9856d19A622A25E2F043171
 * Sepolia-Account2 部署后的合约地址：0x84c8D6ED672008D27807C1d2f422e29d3e38e944
 */
contract BalanceManager {
    mapping(address=>uint256) public balanceOf;

    // ERC20规范要求
    string public name = "MYDOLLAR";
    string public symbol = "$";
    // 一万个数字单位等于1个货币单位，totalBalance=10000的话，如果decimals=4的话，就是只有MYDOLLAR
    // 如果1w MYDOLLAR 就是 totalBalance是100000000，其中四个0是精度
    uint8 public decimals = 4;
    uint256 public totalSupply;

    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor(uint256 initialSupply) {
        totalSupply = initialSupply;
        // 这笔钱给了合约部署者
        balanceOf[msg.sender] = initialSupply;
        emit Transfer(address(0), msg.sender, initialSupply);
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

}