// SPDX-License-Identifier: MIT
pragma solidity 0.7.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract SendEtherRinkeby {
    AggregatorV3Interface internal eth_usd_price_feed;
    AggregatorV3Interface internal jpy_usd_price_feed;
    AggregatorV3Interface internal gbp_usd_price_feed;
    AggregatorV3Interface internal eur_usd_price_feed;
    AggregatorV3Interface internal aud_usd_price_feed;

    constructor() {
        eth_usd_price_feed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        jpy_usd_price_feed = AggregatorV3Interface(0x3Ae2F46a2D84e3D5590ee6Ee5116B80caF77DeCA);
        gbp_usd_price_feed = AggregatorV3Interface(0x7B17A813eEC55515Fb8F49F2ef51502bC54DD40F);
        eur_usd_price_feed = AggregatorV3Interface(0x78F9e60608bF48a1155b4B2A5e31F32318a1d85F);
        aud_usd_price_feed = AggregatorV3Interface(0x21c095d2aDa464A294956eA058077F14F66535af);
    }

    /**
    * @notice contract can receive Ether.
    */

    receive() external payable {}
	
    function getEthUsd() public view returns (int) {
        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = eth_usd_price_feed.latestRoundData();

        return price;
    }


    function getJpyUsd() public view returns (int) {
        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = jpy_usd_price_feed.latestRoundData();

        return price;
    }

    function getEthEur() public view returns (uint) {
        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = eur_usd_price_feed.latestRoundData();

        uint EthUsd = uint(getEthUsd());
        uint EurUsd = uint(price);

        return EthUsd * 10 ** 8 / EurUsd;
    }

    function getEthAud() public view returns (uint) {
        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = aud_usd_price_feed.latestRoundData();

        uint EthUsd = uint(getEthUsd());
        uint AudUsd = uint(price);

        return EthUsd * 10 ** 8 / AudUsd;
    }

    function getEthGbp() public view returns (uint) {
        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = gbp_usd_price_feed.latestRoundData();

        uint EthUsd = uint(getEthUsd());
        uint GbpUsd = uint(price);

        return EthUsd * 10 ** 8 / GbpUsd;
    }

    function getEthJpy() public view returns (uint) {

        uint EthUsd = uint(getEthUsd());
        uint JpyUsd = uint(getJpyUsd());

        return EthUsd * 10 ** 8 / JpyUsd;

    }

    function convertEthUsd(uint _amountInUsd) public view returns (uint) {

        uint EthUsd = uint(getEthUsd());

        return _amountInUsd * 10 ** 16 / EthUsd;

    }
    
    function convertEthJpy(uint _amountInJpy) public view returns (uint) {

        uint EthJpy = uint(getEthJpy());

        return _amountInJpy * 10 ** 16 / EthJpy;

    }

     function convertEthAud(uint _amountInAud) public view returns (uint) {

        uint EthAud = uint(getEthAud());

        return _amountInAud * 10 ** 16 / EthAud;

    }   

     function convertEthEur(uint _amountInEur) public view returns (uint) {

        uint EthEur = uint(getEthAud());

        return _amountInEur * 10 ** 16 / EthEur;

    }   

     function convertEthGbp(uint _amountInGbp) public view returns (uint) {

        uint EthGbp = uint(getEthGbp());

        return _amountInGbp * 10 ** 16 / EthGbp;

    }   

    function sendViaCall(address payable _to) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }

}
