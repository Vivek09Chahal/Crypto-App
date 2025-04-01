//
//  Color.swift
//  Crypto App
//
//  Created by Vivek Chahal on 3/30/25.
//

import Foundation
import SwiftUI

extension Color{
    static let theme = colorTheme()
}

struct colorTheme{
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("DarkGreen")
    let red = Color("DarkRed")
    let secondaryText = Color("SecondaryTextColor")
    
}
