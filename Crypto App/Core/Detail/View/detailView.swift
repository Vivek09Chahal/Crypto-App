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
    
    @StateObject private var vm: detailViewModel
    @State private var showFullDEscription: Bool = false
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let spacing: CGFloat = 30
    
    init(coin: coinModel) {
        _vm = StateObject(wrappedValue: detailViewModel(coin: coin))
        print("Initilizing detail view for \(coin.name)")
    }
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                chartView(coin: vm.coin)
                    .padding(.vertical)
                VStack(spacing: 20){
                    overView
                    Divider()
                    
                    ZStack{
                        if let coinDescription = vm.coinDescription, !coinDescription.isEmpty{
                            VStack(alignment: .leading){
                                Text(coinDescription)
                                    .lineLimit(showFullDEscription ? nil : 3)
                                    .font(.callout)
                                    .foregroundStyle(Color.theme.secondaryText)
                                
                                Button {
                                    withAnimation(.easeInOut) {
                                        showFullDEscription.toggle()
                                    }
                                } label: {
                                    Text(showFullDEscription ? "Less" : "Read more...")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .padding(.vertical, 4)
                                        .foregroundStyle(Color.blue)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        } else {
                            Text("Loading ...")
                        }
                    }
                    
                    overViewGrid
                    
                    additionalTitle
                    Divider()
                    additionalViewGrid
                }
                .padding()
            }
        }
        .navigationTitle(vm.coin.name)
//        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                navigationBarTrailingView
            }
        }
    }
}

struct detailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            detailView(coin: dev.coin)
        }
    }
}

extension detailView{
    
    private var navigationBarTrailingView: some View {
        HStack{
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryText)
            coinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overView: some View {
        Text("OverView")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overViewGrid : some View {
        LazyVGrid(columns: columns,alignment: .leading, spacing: spacing, pinnedViews: []) {
            ForEach(vm.overviewStatistic){ stat in
                statisticView(stat: stat)
            }
        }
    }
    
    private var additionalViewGrid : some View {
        LazyVGrid(columns: columns,alignment: .leading, spacing: spacing, pinnedViews: []) {
            ForEach(vm.additionalStatistic){ stat in
                statisticView(stat: stat)
            }
        }
    }
}
