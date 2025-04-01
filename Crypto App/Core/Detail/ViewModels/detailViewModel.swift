//
//  detailViewModel.swift
//  Crypto App
//
//  Created by Vivek Chahal on 4/1/25.
//

import Foundation
import Combine

class detailViewModel: ObservableObject {
    
    
    private let coinDetailService: coinDetailDataService
    var cancallable = Set<AnyCancellable>()
    
    init(coin: coinModel){
        self.coinDetailService = coinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers(){
        coinDetailService.$coinDetails
            .sink { (returnedCoindetail) in
            print("Receivec coin Detail Data")
        }
            .store(in: &cancallable)
    }
    
}
