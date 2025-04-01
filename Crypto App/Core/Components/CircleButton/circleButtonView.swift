//
//  circleButtonView.swift
//  Crypto App
//
//  Created by Vivek Chahal on 3/30/25.
//

import SwiftUI

struct circleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundStyle(Color.theme.background)
            )
            .shadow(
                color: Color.theme.accent.opacity(0.25),
                radius: 10
            )
            .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Group{
        circleButtonView(iconName: "info")
        circleButtonView(iconName: "plus")
            .preferredColorScheme(.dark)
    }
}
