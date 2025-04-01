//
//  portfolioView.swift
//  Crypto App
//
//  Created by Vivek Chahal on 3/30/25.
//

import SwiftUI

struct portfolioView: View {
    
    @EnvironmentObject private var vm: homeViewModel
    @State private var selectedCoin: coinModel? = nil
    @State private var quantityText = ""
    @State private var showCheckMark = false
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading, spacing: 0){
                    searchBarView(searchText: $vm.searchedText)
                    coinLogoList
                    
                    if selectedCoin != nil{
                        portfolioInputSection
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    trailingNavBarButton
                }
            }
            .onChange(of: vm.searchedText) { oldValue, newValue in
                if newValue.isEmpty{
                    removeSelectedCoin()
                }
            }
        }
    }
}

struct portfolioView_Previews: PreviewProvider {
    static var previews: some View {
        portfolioView()
            .environmentObject(dev.homeVM)
    }
}

extension portfolioView{
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false){
            LazyHStack(spacing: 10){
                ForEach(vm.allCoins){ coin in
                    coinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture(perform: {
                            withAnimation {
                                selectedCoin = coin
                            }
                        })
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear,
                                        lineWidth: 1)
                        }
                }
            }
            .frame(height: 120)
            .padding(.leading)
        }
    }
    
    private func updateSelectedCoin(coin: coinModel){
        selectedCoin = coin
        
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
           let amount = portfolioCoin.currentHoldings{
            quantityText = String(amount)
        } else {
            quantityText = "0"
        }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText){
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioInputSection: some View{
        VStack(spacing: 20) {
            HStack{
                Text("Current Price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencywith6DecimalPlaces() ?? "0.00")
            }
            Divider()
            HStack{
                Text("Amount in your Portfolio")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText )
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack{
                Text("Current Holding")
                Spacer()
                Text(getCurrentValue().asCurrencywith2DecimalPlaces())
            }
        }
        .animation(.default, value: 0)
        .padding()
        .font(.headline)
    }
    
    private var trailingNavBarButton: some View {
        HStack(spacing: 10){
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1.0 : 0.0)
            Button {
                saveButtonPressed()
            } label: {
                Text("Save")
            }
            .opacity(
                (selectedCoin !=  nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
            )
        }
    }
    
    private func saveButtonPressed(){
        guard let coin = selectedCoin,
              let amount = Double(quantityText)
        else { return }
        
        //save to portfolio
        vm.updatePortfolio(coin:coin , amount: amount)
        
        // show checkmark
        withAnimation(.easeIn){
            showCheckMark = true
            removeSelectedCoin()
        }
        //hide keyboard
        UIApplication.shared.endEditing()
        
        //hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            withAnimation(.easeOut) {
                showCheckMark = false
            }
        }
    }
    
    private func removeSelectedCoin(){
        selectedCoin = nil
        vm.searchedText = ""
    }
    
}
