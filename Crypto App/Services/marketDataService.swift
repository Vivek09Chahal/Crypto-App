//
//  marketDataService.swift
//  Crypto App
//
//  Created by Vivek Chahal on 3/30/25.
//

import Foundation
import Combine

class marketDataService {
    
    @Published var marketData: marketDataModel? = nil
//    var cancallable = Set<AnyCancellable>()
    var marketDataSubscription: AnyCancellable?
    
    init(){
        getData()
    }
    
    func getData(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global")
        else {
            return
        }
        
        marketDataSubscription = networkManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: networkManager.handelCompletion, receiveValue: { [weak self] globalData in
                self?.marketData = globalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
