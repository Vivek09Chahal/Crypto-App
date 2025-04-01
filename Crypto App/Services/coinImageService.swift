//
//  coinImageService.swift
//  Crypto App
//
//  Created by Vivek Chahal on 3/30/25.
//

import Foundation
import SwiftUI
import Combine
 
class coinImageService {
    
    @Published var image: UIImage? = nil
    
    var imageSubscription: AnyCancellable?
    private let coin: coinModel
    
    private let fileManager = localFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: coinModel){
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    func getCoinImage(){
        if let savedImage = fileManager.getImages(imageName: imageName, folderName: folderName){
            image = savedImage
        } else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage(){
        
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription =  networkManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: networkManager.handelCompletion, receiveValue: { [weak self] returnedImage in
                guard let self = self, let downloadImage = returnedImage else { return }
                self.image = downloadImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImages(image: downloadImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
