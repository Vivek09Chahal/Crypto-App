//
//  detailViewModel.swift
//  Crypto App
//
//  Created by Vivek Chahal on 4/1/25.
//

import Foundation
import Combine

class detailViewModel: ObservableObject {
    
    @Published var overviewStatistic: [statisticModel] = []
    @Published var additionalStatistic: [statisticModel] = []
    
    @Published var coin: coinModel
    private let coinDetailService: coinDetailDataService
    var cancallable = Set<AnyCancellable>()
    
    init(coin: coinModel){
        self.coin = coin
        self.coinDetailService = coinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers(){
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map ( mapDataToStatistic )
            .sink { [weak self] (returnedArrays) in
                self?.overviewStatistic = returnedArrays.overview
                self?.additionalStatistic = returnedArrays.additional
            }
            .store(in: &cancallable)
    }
    
    private func mapDataToStatistic (coinDetailModel: coinDetailModel?, coinModel: coinModel) -> (overview: [statisticModel], additional:[statisticModel]){
        
        //overview
        let price = coinModel.currentPrice.asCurrencywith6DecimalPlaces()
        let pricePercentageChange = coinModel.priceChangePercentage24H
        let priceStat = statisticModel(title: "Current Price", value: price, percentageChange: pricePercentageChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "0")
        let marketCapPercentageChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = statisticModel(title: "Market Cap", value: marketCap, percentageChange: marketCapPercentageChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = statisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "0")
        let volumeStat = statisticModel(title: "Volume", value: volume)
        
        let overViewArray: [statisticModel] = [priceStat, marketCapStat, rankStat, volumeStat]
        
        //additional
        let high = coinModel.high24H?.asCurrencywith6DecimalPlaces() ?? "n/a"
        let highStat = statisticModel(title: "High 24h", value: high)
        
        let low = coinModel.low24H?.asCurrencywith6DecimalPlaces() ?? "n/a"
        let lowStat = statisticModel(title: "Low 24h", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencywith6DecimalPlaces() ?? "n/a"
        let pricePercentageChange2 = coinModel.priceChangePercentage24H
        let pricePercentStat = statisticModel(title: "Price Change 24h", value: priceChange, percentageChange: pricePercentageChange2)
        
        let marketCapChange = coinModel.marketCapChangePercentage24H?.formattedWithAbbreviations() ?? "n/a"
        let marketCapPercentageChange2 = coinModel.marketCapChangePercentage24H
        let marketCapPercentStat = statisticModel(title: "Market Cap Change 24h", value: marketCapChange, percentageChange: marketCapPercentageChange2)
        
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockTimeStat = statisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = statisticModel(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray = [highStat, lowStat, pricePercentStat, marketCapPercentStat, blockTimeStat, hashingStat]
        
        return ( overViewArray, additionalArray)
    }
    
}
