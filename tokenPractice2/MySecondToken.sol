pragma solidity ^0.3.9;

import "browser/Token.sol";
import "browser/ERC20.sol";
import "browser/ERC223.sol";
import "browser/ERC223ReceivingContract.sol";

contract MySecondToken is Token("SET", "My Second Token", 18, 1000), ERC20, ERC223 {

    //constructor, runs only once while compiling - here we're kicking off our total supply by funding from a single wallet
    //same name as contract
    function MySecondToken() public {
        _balanceOf[msg.sender] = _totalSupply;
    }

    function totalSupply() public constant returns (uint) {
        return _totalSupply;
    }

    function balanceOf(address _addr) public constant returns (uint) {
        return _balanceOf[_addr];
    }

    //for any transfer check that: 1. the value sent is greater than 0 2. balance of wallet sender is greater than the value being sent 3. the address being sent the value is not a contract (but a wallet)
    function transfer(address _to, uint _value) public returns (bool) {
        if (_value > 0 &&
            _value <= _balanceOf[msg.sender] &&
            !isContract(_to)) {
            _balanceOf[msg.sender] -= _value;
            _balanceOf[_to] += _value;
            Transfer(msg.sender, _to, _value);
            return true;
        }
        return false;
    }

    // using two different transfer functions for our two different possible underlying interfaces, ERC20 && ERC223
    // this transfer function includes the ERC223 fallback contract in order to not have network of lose tokens
    function transfer(address _to, uint _value, bytes _data) public returns (bool) {
        if (_value > 0 &&
            _value <= _balanceOf[msg.sender] &&
            isContract(_to)) {
            _balanceOf[msg.sender] -= _value;
            _balanceOf[_to] += _value;
            ERC223ReceivingContract _contract = ERC223ReceivingContract(_to);
                _contract.tokenFallback(msg.sender, _value, _data);
            Transfer(msg.sender, _to, _value, _data);
            return true;
        }
        return false;
    }

    function isContract(address _addr) returns (bool) {
        uint codeSize;
        assembly {
            codeSize := extcodesize(_addr)
        }
        return codeSize > 0;
    }

    //The transferFrom method is used for a withdraw workflow, allowing contracts to transfer tokens programmatically.
    //This can be used for example to allow a contract to transfer tokens on your behalf or charge fees in sub-currencies
    function transferFrom(address _from, address _to, uint _value) public returns (bool) {
        if (_allowances[_from][msg.sender] > 0 &&
            _value > 0 &&
            _allowances[_from][msg.sender] >= _value &&
            _balanceOf[_from] >= _value) {
            _balanceOf[_from] -= _value;
            _balanceOf[_to] += _value;
            _allowances[_from][msg.sender] -= _value;
            Transfer(_from, _to, _value);
            return true;
        }
        return false;
    }

    function approve(address _spender, uint _value) public returns (bool) {
        _allowances[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    // Returns the amount which _spender is still allowed to withdraw from _owner
    function allowance(address _owner, address _spender) public constant returns (uint) {
        return _allowances[_owner][_spender];
    }
}
