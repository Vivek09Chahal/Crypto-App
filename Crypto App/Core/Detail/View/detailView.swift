//
//  detailView.swift
//  Crypto App
//
//  Created by Vivek Chahal on 4/1/25.
//

import SwiftUI

struct detailLoadingView: View {
    
    @Binding var coin: coinModel?
    
    var body: some View {
        ZStack{
            if let coin = coin{
                detailView(coin: coin)
            }
        }
    }
}

struct detailView: View {
    
    @StateObject var vm: detailViewModel
    let coin: coinModel
    
    init(coin: coinModel) {
        self.coin = coin
        _vm = StateObject(wrappedValue: detailViewModel(coin: coin))
        print("Initilizing detail view for \(coin.name)")
    }
    
    var body: some View {
        VStack{
            
        }
    }
}

struct detailView_Previews: PreviewProvider {
    static var previews: some View {
        detailView(coin: dev.coin)
    }
}
