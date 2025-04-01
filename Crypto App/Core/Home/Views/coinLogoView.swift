//
//  coinLogoView.swift
//  Crypto App
//
//  Created by Vivek Chahal on 3/30/25.
//

import SwiftUI

struct coinLogoView: View {
    
    let coin: coinModel
    
    var body: some View {
        VStack{
            coinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

struct coinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        coinLogoView(coin: dev.coin)
    }
}
