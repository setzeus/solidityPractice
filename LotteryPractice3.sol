pragma solidity ^0.4.20;

contract LotteryPractice3 {

    //Global Variables
    uint[] _availableTickets = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];


    //Purchased Lottery Ticket struct, event & Purchased Lottery Ticket Arrays
    struct _purchasedLotteryTicket {
        address _ticketBuyer;
        uint _ticketNumber;
    }
    event __purchasedLotteryTicket(
        address ___ticketBuyer,
        uint ___ticketNumber
    );
    event LotteryBuyers (
        address[] buyers
    );
    event LotteryNumbers (
        uint[] numbers
    );
    _purchasedLotteryTicket[] _purchasedLotteryTickets;
    address[] _buyerAddresses;
    uint[] _ticketNumbersPurchased;
    mapping(address => _purchasedLotteryTicket) _purchasedLotteryTicketBuyer;






    function purchaseLotteryTicket(address _ticketPurchaser, uint _ticketPurchasedNumber) payable public returns (uint[] _ticketsRemainingAfterPurchase) {
        var lotteryTicket = _purchasedLotteryTicketBuyer[_ticketPurchaser];
        require(msg.value == .5 ether);

        lotteryTicket._ticketBuyer = _ticketPurchaser;
        lotteryTicket._ticketNumber = _ticketPurchasedNumber;
        setPurchasedLotteryAddressesInAnArray(lotteryTicket._ticketBuyer);
        setPurchasedLotteryNumbersInAnArray(lotteryTicket._ticketNumber);


        uint testRemove = 16 - _availableTickets.length + 1;
        remove(_ticketPurchasedNumber - testRemove);

        return _availableTickets;
    }




    function ticketsPurchasedAddresses() private returns(address[]) {
        LotteryBuyers(_buyerAddresses);
        return _buyerAddresses;
    }
    function ticketsPurchasedNumbers() private returns(uint[]) {
        LotteryNumbers(_ticketNumbersPurchased);
        return _ticketNumbersPurchased;
    }
    function lotteryTicketsPurchased() {
        ticketsPurchasedAddresses();
        ticketsPurchasedNumbers();
    }
    function ticketsRemaining() public returns(uint[]) {
        return _availableTickets;
    }




    //helper functions
    function setPurchasedLotteryAddressesInAnArray(address _TicketBuyer) private returns(address[]) {
        _buyerAddresses.push(_TicketBuyer);
        return _buyerAddresses;
    }
    function setPurchasedLotteryNumbersInAnArray(uint _TicketNumber) private returns(uint[]) {
        _ticketNumbersPurchased.push(_TicketNumber);
        return _ticketNumbersPurchased;
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
