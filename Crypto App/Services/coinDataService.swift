//
//  coinDataService.swift
//  Crypto App
//
//  Created by Vivek Chahal on 3/30/25.
//

import Foundation
import Combine

class coinDataService {
    
    @Published var allCoins: [coinModel] = []
//    var cancallable = Set<AnyCancellable>()
    var coinSubscription: AnyCancellable?
    
    init(){
        getCoins()
    }
    
    func getCoins(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
        else {
            return
        }
        
        coinSubscription =  networkManager.download(url: url)
            .decode(type: [coinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: networkManager.handelCompletion, receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}
