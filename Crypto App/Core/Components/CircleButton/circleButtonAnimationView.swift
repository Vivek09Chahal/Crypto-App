//
//  circleButtonAnimationView.swift
//  Crypto App
//
//  Created by Vivek Chahal on 3/30/25.
//

import SwiftUI

struct circleButtonAnimationView: View {
    
    @Binding var isAnimating: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(isAnimating ? 1.0 : 0)
            .opacity(isAnimating ? 0.0 : 1.0)
            .animation(Animation.easeInOut(duration: 1.0), value: isAnimating)
    }
}

#Preview {
    circleButtonAnimationView(isAnimating: .constant(false))
        .foregroundStyle(.red)
        .frame(width: 100, height: 100)
}
