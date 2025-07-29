# 🔮 Prediction Market DApp

## Project Vision

To create a decentralized, transparent, and automated prediction market platform that empowers users to bet on future events with guaranteed payouts, fostering a community-driven ecosystem for forecasting and collective intelligence.

## Project Description

The Prediction Market DApp is a blockchain-based platform built on Ethereum that allows users to create markets for future events and place bets on their outcomes. The smart contract handles all betting logic, fund management, and automated payouts without requiring intermediaries. Users can create markets on any future event, place YES/NO bets, and receive proportional payouts based on the total pool and their stake when markets resolve.

The platform operates on a simple yet powerful mechanism: users contribute to either the YES or NO side of a prediction, and when the market resolves, winners receive payouts proportional to their contribution and the total pool size. This creates natural price discovery and incentivizes accurate predictions.

## Key Features

### 🎯 **Market Creation**
- Anyone can create prediction markets for future events
- Flexible duration settings for market closure
- Unique market IDs for easy tracking and management

### 💰 **Decentralized Betting**
- Place YES/NO bets on any active market
- Secure fund locking in smart contract
- One bet per user per market to ensure fairness

### ⚖️ **Automated Resolution**
- Owner-controlled market resolution system
- Transparent outcome recording on blockchain
- Immutable resolution once markets are closed

### 🎉 **Guaranteed Payouts**
- Automatic calculation of proportional winnings
- Secure fund distribution to winners
- Gas-efficient claiming mechanism

### 📊 **Market Analytics**
- Real-time betting pool tracking (YES vs NO)
- Market information and statistics
- User betting history and claim status

### 🔒 **Security Features**
- Prevent double betting on same market
- Time-locked market resolution
- Secure fund handling with failure protection

## Future Scope

### Phase 1 - Enhanced Features
- **Oracle Integration**: Implement Chainlink oracles for automated market resolution based on real-world data
- **Multiple Outcome Markets**: Expand beyond YES/NO to support multiple choice predictions
- **Market Categories**: Add categorization system (Sports, Politics, Crypto, Weather, etc.)

### Phase 2 - Advanced Functionality  
- **Liquidity Pools**: Implement AMM-style liquidity provision for better market making
- **Partial Betting**: Allow users to place multiple smaller bets instead of single large ones
- **Market Maker Rewards**: Incentivize early market creators and liquidity providers

### Phase 3 - Platform Expansion
- **Cross-Chain Support**: Deploy on multiple blockchains (Polygon, BSC, Arbitrum)
- **Mobile App**: Native mobile application for iOS and Android
- **Social Features**: User profiles, following, market sharing, and community discussions

### Phase 4 - Governance & Tokenization
- **DAO Governance**: Implement token-based governance for platform decisions
- **Native Token**: Launch platform token for staking, governance, and fee discounts
- **Reputation System**: Build user reputation based on prediction accuracy

### Phase 5 - Enterprise Features
- **API Access**: Provide APIs for third-party integrations
- **Institutional Features**: Advanced analytics, bulk operations, and custom markets
- **Regulatory Compliance**: Implement KYC/AML features for regulated markets

## Smart Contract Functions

### Core Functions
1. **`createMarket()`** - Create new prediction markets
2. **`placeBet()`** - Place YES/NO bets on active markets  
3. **`resolveMarket()`** - Resolve markets with final outcomes
4. **`claimWinnings()`** - Claim proportional payouts for winners
5. **`getMarketInfo()`** - Retrieve comprehensive market data

## Getting Started

### Prerequisites
- Node.js v16+
- Hardhat or Truffle
- MetaMask wallet
- Test ETH for deployment

### Installation
```bash
npm install @openzeppelin/contracts
npx hardhat compile
npx hardhat deploy --network <network-name>
```

### Usage
1. Deploy the contract to your preferred network
2. Create markets using `createMarket()`
3. Users place bets with `placeBet()`
4. Resolve markets after events conclude
5. Winners claim payouts automatically

## License
MIT License - Feel free to use, modify, and distribute

---

*Built with ❤️ for the decentralized future of prediction markets*
## contract Details : 0x5DB13c00E93E8Bf3b9Ab76ADe7D443d1F124B458
<img width="1900" height="856" alt="image" src="https://github.com/user-attachments/assets/a680fd37-b7ba-42ca-8182-debabf5328d8" />
