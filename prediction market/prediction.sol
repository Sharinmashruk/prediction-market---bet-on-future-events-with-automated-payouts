// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract PredictionMarket {
    address public owner;
    uint256 public marketCounter;
    
    struct Market {
        uint256 id;
        string question;
        uint256 endTime;
        bool resolved;
        bool outcome;
        uint256 totalYesBets;
        uint256 totalNoBets;
        address creator;
        bool exists;
    }
    
    struct Bet {
        uint256 amount;
        bool prediction;
        bool claimed;
    }
    
    mapping(uint256 => Market) public markets;
    mapping(uint256 => mapping(address => Bet)) public bets;
    mapping(uint256 => address[]) public marketBettors;
    
    event MarketCreated(uint256 indexed marketId, string question, uint256 endTime, address creator);
    event BetPlaced(uint256 indexed marketId, address indexed bettor, uint256 amount, bool prediction);
    event MarketResolved(uint256 indexed marketId, bool outcome);
    event PayoutClaimed(uint256 indexed marketId, address indexed winner, uint256 amount);
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    
    modifier marketExists(uint256 _marketId) {
        require(markets[_marketId].exists, "Market does not exist");
        _;
    }
    
    constructor() {
        owner = msg.sender;
        marketCounter = 0;
    }
    
    /**
     * @dev Create a new prediction market
     * @param _question The question/event to bet on
     * @param _duration Duration in seconds from now until market closes
     */
    function createMarket(string memory _question, uint256 _duration) external returns (uint256) {
        require(_duration > 0, "Duration must be greater than 0");
        require(bytes(_question).length > 0, "Question cannot be empty");
        
        marketCounter++;
        uint256 endTime = block.timestamp + _duration;
        
        markets[marketCounter] = Market({
            id: marketCounter,
            question: _question,
            endTime: endTime,
            resolved: false,
            outcome: false,
            totalYesBets: 0,
            totalNoBets: 0,
            creator: msg.sender,
            exists: true
        });
        
        emit MarketCreated(marketCounter, _question, endTime, msg.sender);
        return marketCounter;
    }
    
    /**
     * @dev Place a bet on a market
     * @param _marketId The ID of the market to bet on
     * @param _prediction True for YES, False for NO
     */
    function placeBet(uint256 _marketId, bool _prediction) external payable marketExists(_marketId) {
        require(msg.value > 0, "Bet amount must be greater than 0");
        require(block.timestamp < markets[_marketId].endTime, "Market has ended");
        require(!markets[_marketId].resolved, "Market already resolved");
        require(bets[_marketId][msg.sender].amount == 0, "Already placed bet on this market");
        
        bets[_marketId][msg.sender] = Bet({
            amount: msg.value,
            prediction: _prediction,
            claimed: false
        });
        
        marketBettors[_marketId].push(msg.sender);
        
        if (_prediction) {
            markets[_marketId].totalYesBets += msg.value;
        } else {
            markets[_marketId].totalNoBets += msg.value;
        }
        
        emit BetPlaced(_marketId, msg.sender, msg.value, _prediction);
    }
    
    /**
     * @dev Resolve a market with the final outcome
     * @param _marketId The ID of the market to resolve
     * @param _outcome True if YES wins, False if NO wins
     */
    function resolveMarket(uint256 _marketId, bool _outcome) external onlyOwner marketExists(_marketId) {
        require(block.timestamp >= markets[_marketId].endTime, "Market has not ended yet");
        require(!markets[_marketId].resolved, "Market already resolved");
        
        markets[_marketId].resolved = true;
        markets[_marketId].outcome = _outcome;
        
        emit MarketResolved(_marketId, _outcome);
    }
    
    /**
     * @dev Claim winnings from a resolved market
     * @param _marketId The ID of the market to claim from
     */
    function claimWinnings(uint256 _marketId) external marketExists(_marketId) {
        require(markets[_marketId].resolved, "Market not resolved yet");
        require(bets[_marketId][msg.sender].amount > 0, "No bet placed");
        require(!bets[_marketId][msg.sender].claimed, "Already claimed winnings");
        require(bets[_marketId][msg.sender].prediction == markets[_marketId].outcome, "Bet lost");
        
        uint256 betAmount = bets[_marketId][msg.sender].amount;
        uint256 totalPool = markets[_marketId].totalYesBets + markets[_marketId].totalNoBets;
        uint256 winningPool = markets[_marketId].outcome ? markets[_marketId].totalYesBets : markets[_marketId].totalNoBets;
        
        // Calculate proportional winnings
        uint256 payout = (betAmount * totalPool) / winningPool;
        
        bets[_marketId][msg.sender].claimed = true;
        
        (bool success, ) = payable(msg.sender).call{value: payout}("");
        require(success, "Transfer failed");
        
        emit PayoutClaimed(_marketId, msg.sender, payout);
    }
    
    /**
     * @dev Get market details and betting information
     * @param _marketId The ID of the market
     */
    function getMarketInfo(uint256 _marketId) external view marketExists(_marketId) returns (
        string memory question,
        uint256 endTime,
        bool resolved,
        bool outcome,
        uint256 totalYesBets,
        uint256 totalNoBets,
        address creator
    ) {
        Market memory market = markets[_marketId];
        return (
            market.question,
            market.endTime,
            market.resolved,
            market.outcome,
            market.totalYesBets,
            market.totalNoBets,
            market.creator
        );
    }
    
    // Additional utility functions
    function getUserBet(uint256 _marketId, address _user) external view returns (uint256 amount, bool prediction, bool claimed) {
        Bet memory bet = bets[_marketId][_user];
        return (bet.amount, bet.prediction, bet.claimed);
    }
    
    function getMarketBettors(uint256 _marketId) external view returns (address[] memory) {
        return marketBettors[_marketId];
    }
}
