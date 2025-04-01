//
//  coinImageView.swift
//  Crypto App
//
//  Created by Vivek Chahal on 3/30/25.
//

import SwiftUI

struct coinImageView: View {
    
    @StateObject var vm: coinIMageViewModel
    
    init(coin: coinModel){
        _vm = StateObject(wrappedValue: coinIMageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack{
            if let image = vm.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading{
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondaryText)
            }
        }
    }
}

struct coinImageView_Previews: PreviewProvider {
    static var previews: some View {
        coinImageView(coin: dev.coin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
