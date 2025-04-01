//
//  homeViewModel.swift
//  Crypto App
//
//  Created by Vivek Chahal on 3/30/25.
//

import Foundation
import Combine

class  homeViewModel: ObservableObject {
    
    @Published var statistic: [statisticModel] = []
    
    @Published var allCoins: [coinModel] = []
    @Published var portfolioCoins: [coinModel] = []
    @Published var searchedText: String = ""
    @Published var isLoading: Bool = false
    
    private let CoinDataService = coinDataService()
    private let MarketDataService = marketDataService()
    private let PortfolioDataService = portfolioDataService()
    private var cancallable = Set<AnyCancellable>()
    
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // update all coins as well
        $searchedText
            .combineLatest(CoinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map ( filterCoin )
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancallable)
        
        //update portfolio coins
        $allCoins
            .combineLatest(PortfolioDataService.$savedEntities)
            .map ( mapAllCoinToPortfolioCoin )
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancallable)
        
        //update market Data
        MarketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistic = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancallable)
    }
    
    func updatePortfolio(coin: coinModel, amount: Double){
        PortfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData(){
        isLoading = true
        CoinDataService.getCoins()
        MarketDataService.getData()
        hapticManager.notification(type: .success)
    }
    
    private func filterCoin(text: String, coins: [coinModel]) -> [coinModel] {
        guard !searchedText.isEmpty else {
            return coins
        }
        
        let lowercasedText = searchedText.lowercased()
        return coins.filter { coin -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private func mapAllCoinToPortfolioCoin(allCoin: [coinModel], portfolioEntities: [PortfolioEntity]) -> [coinModel]{
        allCoin
            .compactMap { coin -> coinModel? in
            guard let entities = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                return nil
            }
            return coin.updateHoldings(amount: entities.amount)
        }
    }
    
    private func mapGlobalMarketData(marketDataModel: marketDataModel?, portfolioCoins: [coinModel]) -> [statisticModel] {
        var stats: [statisticModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = statisticModel(title: "MarketCap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = statisticModel(title: "24H Volume", value: data.volume)
        let btcDominance = statisticModel(title: "BTC Dominance", value: data.btcDominance)
        
//        let portfolioValue = portfolioCoins.map { coin -> Double in
//            return coin.currentHoldingsValue
//        }
        //OR
        let portfolioValue = portfolioCoins
            .map { $0.currentHoldingsValue }
            .reduce(0, +)
        
        let previousValue = portfolioCoins
            .map { coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = coin.priceChangePercentage24H / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
                
                //25% -> 25
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = statisticModel(title: "Portfolio", value: portfolioValue.asCurrencywith2DecimalPlaces(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
    
}
