pragma solidity ^0.4.18;

contract LotteryPractice {

    event winningLotteryNumbers(
            uint256 _secondLast,
            uint256 _last,
            bytes32 testHash,
            uint256 testNum
        );

    function LotteryPractice () {

        bytes32 myHash = block.blockhash(block.number - 1);
        uint256 hashNum = uint256(myHash);

        // Last Character alone
        // Shift left by 252 bits (leaving just 4 bits left), then shift back to the right
        uint256 last = (hashNum * 2 ** 252) / (2 ** 252);

        // Second to last character alone
        // Shift left by 248 bits (leaving 8 bits left), but then shift right by 252
        uint256 secondLast = (hashNum * 2 ** 248) / (2 ** 252);

        winningLotteryNumbers(secondLast,last,myHash,hashNum);
    }


}
