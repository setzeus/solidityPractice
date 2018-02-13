pragma solidity ^0.4.18;

//16 person lottery that only unlocks once completely filled
//start with list of available tickets that are number 1 - 16
//users purchase a ticket, that is now removed from available tickets
//a new array records, for users that send the right amount, the ticket number & address sent from
//once all tickets are purchased, award an address, based on a pgrn, the total lottery amount

contract LotteryPractice {

    uint _totalTickets = 16;

    event ticketInfo(
            uint _ticketAmount,
            bool _purchased,
            address _owner
        );

    event winningLotteryNumbers(
            uint256 _last,
            bytes32 testHash,
            uint256 testNum
        );

    event testLoggingArrays(
           address [] lotteryTickets,
           uint _totalTicketsLeft
        );

    function LotteryPractice () {

        bytes32 myHash = block.blockhash(block.number - 1);
        uint256 hashNum = uint256(myHash);

        // Last Character alone
        // Shift left by 252 bits (leaving just 4 bits left), then shift back to the right
        uint256 last = (hashNum * 2 ** 252) / (2 ** 252);


        winningLotteryNumbers(last,myHash,hashNum);
    }



    struct lotteryTicket {
        uint ticketAmount;
        bool purchased;
        address owner;
    }

    mapping(address => lotteryTicket) lotteryTickets;

    address[] public allLotteryTickets;



    function purchaseLotteryTicket(address _ticketBuyer) public payable returns(bool) {
        var lotteryTicket = lotteryTickets[_ticketBuyer];
        require(msg.value == .5 ether);


        lotteryTicket.ticketAmount = msg.value;
        lotteryTicket.owner = _ticketBuyer;
        lotteryTicket.purchased = true;

        allLotteryTickets.push(_ticketBuyer);
        _totalTickets = _totalTickets - 1;

        ticketInfo(lotteryTicket.ticketAmount,lotteryTicket.purchased,lotteryTicket.owner);
        testLoggingArrays(allLotteryTickets,_totalTickets);


        return lotteryTicket.purchased;
    }


}
