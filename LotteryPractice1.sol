pragma solidity ^0.4.20;

//16 person lottery that only unlocks once completely filled
//
// array of available tickets that are numbered 1 - 16
// an empty array of purchasedLotteryTickets strucs
// purchasedLotteryTickets are strucs made up of an address purchaser & a uint ticketNumber
// a new array records, for users that send the right amount, the ticket number & address sent from
// once all tickets are purchased, award an address, based on a pgrn, the total lottery amount

// buy ticket function (ticketChoice) return (confirmation, tickets remaining); if ticketChoice is not available or out of range, or if the etherAmount != .5 ether, reject ticket purchase
// check remaining tickets function () return ([]uint availableTickets)

contract LotteryPractice1 {

        function LotteryPractice1 () {

        bytes32 myHash = block.blockhash(block.number - 1);
        uint256 hashNum = uint256(myHash);

        // Last Character alone
        // Shift left by 252 bits (leaving just 4 bits left), then shift back to the right
        uint256 last = (hashNum * 2 ** 252) / (2 ** 252);

    }

    uint[] _availableTickets = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];

    struct _purchasedLotteryTicket {
        address _ticketBuyer;
        uint _ticketNumber;
        uint _etherReceived;
    }

    _purchasedLotteryTicket[] _surprisedIfThisWorks;

    mapping(address => _purchasedLotteryTicket) _purchasedLotteryTicketBuyer;

    address[] _purchasedLotteryTickets;

    function purchaseLotteryTicket(address _ticketPurchaser, uint _ticketPurchasedNumber) payable public returns (uint[] _ticketsRemainingAfterPurchase) {
        var lotteryTicket = _purchasedLotteryTicketBuyer[_ticketPurchaser];
        require(msg.value == .5 ether);

        lotteryTicket._etherReceived = msg.value;
        lotteryTicket._ticketBuyer = _ticketPurchaser;
        lotteryTicket._ticketNumber = _ticketPurchasedNumber;

        _purchasedLotteryTickets.push(_ticketPurchaser);

        uint testRemove = 16 - _availableTickets.length + 1;
        remove(_ticketPurchasedNumber - testRemove);

        _purchasedLotteryTicket memory testStruct = _purchasedLotteryTicket(msg.sender,_ticketPurchasedNumber,msg.value);

        _surprisedIfThisWorks.push(testStruct);

        return _availableTickets;
    }

    function ticketsRemaining() public returns(uint[]) {
        return _availableTickets;
    }

    function ticketsPurchasedAddresses() public returns(address[]) {
        return _purchasedLotteryTickets;
    }

    function ticketsPurchased() public returns(_purchasedLotteryTicket[]) {
        return _surprisedIfThisWorks;
    }

    function remove(uint index) private returns(uint[]) {
        if (1 >= _availableTickets.length) return;

        for (uint i = index; i<_availableTickets.length-1; i++){
            _availableTickets[i] = _availableTickets[i+1];
        }
        delete _availableTickets[_availableTickets.length-1];
        _availableTickets.length--;
        return _availableTickets;
    }



}
