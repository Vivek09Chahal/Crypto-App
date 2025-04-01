//
//  UIApplication.swift
//  Crypto App
//
//  Created by Vivek Chahal on 3/30/25.
//

import Foundation
import SwiftUI

extension UIApplication{
    
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
