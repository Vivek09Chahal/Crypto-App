//
//  searchBarView.swift
//  Crypto App
//
//  Created by Vivek Chahal on 3/30/25.
//

import SwiftUI

struct searchBarView: View {

    @Binding var searchText: String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent
                )
            
            TextField("Search", text: $searchText)
                .foregroundStyle(Color.theme.accent)
                .autocorrectionDisabled(true)
                .overlay (
                    Image(systemName: "multiply.circle.fill")
                        .padding()
                        .offset(x: 15)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    ,
                    alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.theme.background)
                .shadow(radius: 2)
        )
        .padding()
    }
}

#Preview {
    searchBarView(searchText: .constant(""))
}
