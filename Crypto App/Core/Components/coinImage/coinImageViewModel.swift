//
//  coinImageViewMode;.swift
//  Crypto App
//
//  Created by Vivek Chahal on 3/30/25.
//

import Foundation
import SwiftUI
import Combine

class coinIMageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    private var cancallable = Set<AnyCancellable>()
    
    private let coin: coinModel
    private let dataService: coinImageService
    
    init(coin: coinModel){
        self.coin = coin
        self.dataService = coinImageService(coin: coin)
        self.addSubscribers()
    }
    
    func addSubscribers(){
        
        dataService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancallable)
            
        
    }
    
}
