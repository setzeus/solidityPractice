pragma solidity ^0.4.9;
import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";

contract guessExchangeRate is usingOraclize {

    string public EURUSD;
    event updatedPrice(string price);
    event testOraclizeQuery(string description);

    function guessExchangeRate() payable {
        updatePrice();
    }

    function __callback(bytes32 myid, string result) {
        if (msg.sender != oraclize_cbAddress()) throw;
        EURUSD = result;
        updatedPrice(result);
    }

    function fetchExchangeRate() payable {
        if (oraclize_getPrice("URL") > this.balance) {
            testOraclizeQuery("Oraclize fee not covered, query failed");
        } else {
            testOraclizeQuery("Oraclize query passed");
            oraclize_query("URL", "json(http://api.fixer.io/latest?symbols=USD,EUR).rates.USD");
        }
    }
}
