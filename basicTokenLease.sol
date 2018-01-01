// time-based events, like random, are very tricky in a blockchain environment
// in Solidity, this is done in one of two ways: leveraging the timestamp on blocks
// or through external triggering

pragma solidity ^0.4.0;

// going to create a very mvp (not even ERC20) token that we'll lease out in exchange for a single ether

contract tokenLease {

    // assigning a token balance & expiration variable to each wallet address
    mapping(address => uint) public _balanceOf;
    mapping(address => uint) public _expiryOf;

    // length of our lease, 1 minute
    // note - time events from blocks beginning counting from when they're first discovered
    uint private leaseTime = 60;

    // modifier that checks the expiration date of the user calling our main lease function by their wallet address
    modifier expire(address _addr) {
        if (_expiryOf[_addr] < block.timestamp) {
            _expiryOf[_addr] = 0;
            _balanceOf[_addr] = 0;
        }
        _;
    }

    // main lease function with two modifiers (public & expire)
    function lease() public payable expire(msg.sender) returns (bool) {
        //require is cheaper than conditional statements gas-wise
        //make sure we're receiving an ether & the corresponding wallet has zero tokens
        require(msg.value == 1 ether);
        require(_balanceOf[msg.sender] == 0);
        _balanceOf[msg.sender] = 1;
        _expiryOf[msg.sender] = block.timestamp + leaseTime;
        return true;
    }

    function balanceOf() public returns (uint) {
        return balanceOf(msg.sender);
    }

    function balanceOf(address _addr) public expire(_addr) returns (uint) {
        return _balanceOf[_addr];
    }

    function expiryOf() public returns (uint) {
        return expiryOf(msg.sender);
    }

    function expiryOf(address _addr) public expire(_addr) returns (uint) {
        return _expiryOf[_addr];
    }
}
