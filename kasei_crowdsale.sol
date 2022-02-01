pragma solidity ^0.5.17;

import "./kasei_coin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";

contract KaseiCoinCrowdsale is Crowdsale , MintedCrowdsale {
    constructor(uint rate, address payable wallet, KaseiCoin token) Crowdsale(rate, wallet, token) public {

    }

}

contract KaseiCrowdSaleDeployer{

    address public kasei_coin_address;
    address public kasei_crowdsale_address;

    constructor(string memory name, string memory symbol, address payable wallet) public {

        KaseiCoin token = new KaseiCoin(name, symbol, 0);
        kasei_coin_address = address(token);

        KaseiCoinCrowdsale kasei_crowdsale = new KaseiCoinCrowdsale(1, wallet, token);
        kasei_crowdsale_address = address(kasei_crowdsale);

        token.addMinter(kasei_crowdsale_address);
        token.renounceMinter();

    }
}
