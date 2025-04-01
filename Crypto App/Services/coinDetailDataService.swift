//
//  coinDetailDataService.swift
//  Crypto App
//
//  Created by Vivek Chahal on 4/1/25.
//

import Foundation
import Combine

class coinDetailDataService: ObservableObject {
    
    @Published var coinDetails: coinDetailModel? = nil
    //    var cancallable = Set<AnyCancellable>()
    var coinDetailSubscription: AnyCancellable?
    let coin: coinModel
    
    init(coin: coinModel){
        self.coin = coin
        getCoins()
    }
    
    func getCoins(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
        else {
            return
        }
        
        coinDetailSubscription =  networkManager.download(url: url)
            .decode(type: coinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: networkManager.handelCompletion, receiveValue: { [weak self] returnedCoinDetails in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
}
