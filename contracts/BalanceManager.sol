// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title BalanceManager
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 * 基本符合ERC20规范的智能合约，形式上就可以表达一种资产，一种token，这种token能够用metamask钱包来进行操作
 * Sepolia-Account1: 0x9fB0CDD6C5138E146aA3f0215cff57A263B45670
 * Sepolia-Account1 部署后的合约地址：0x21ADC7ECfB0882F24eA54b9631B5356Cdb7dFdd2
 * Sepolia-Account2: 0x25D0b43D15e355aFF9856d19A622A25E2F043171
 */
contract BalanceManager {
    mapping(address=>uint256) public balanceOf;

    // ERC20规范要求
    string public name = "MYDOLLAR";
    string public symbol = "$";
    // 一万个数字单位等于1个货币单位，totalBalance=10000的话，如果decimals=4的话，就是只有MYDOLLAR
    // 如果1w MYDOLLAR 就是 totalBalance是100000000，其中四个0是精度
    uint8 public decimals = 4;


    constructor(uint totalBalance) {
        // 这笔钱给了合约部署者
        balanceOf[msg.sender] = totalBalance;
    }

    // sender account address: 0x08b3ae2c2Ce1536Ea4D82bE0BDb7aB561E7090ef 合约部署者
    // receiver account address: 0xe6E29b1af76f8b645DC941E618060b946Df002bF
    function transfter(address to, uint256 amount) public {
        address from = msg.sender;
        uint256 fb = balanceOf[from];
        uint256 tb = balanceOf[to];
        require(fb >= amount, "Insufficient balance");
        balanceOf[from] = fb - amount;
        balanceOf[to] = tb + amount;
    }

    // 部署后的合约地址：0x21ADC7ECfB0882F24eA54b9631B5356Cdb7dFdd2



}