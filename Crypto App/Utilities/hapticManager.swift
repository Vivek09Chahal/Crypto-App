//
//  hapticManager.swift
//  Crypto App
//
//  Created by Vivek Chahal on 4/1/25.
//

import Foundation
import SwiftUI

class hapticManager{
    
    static let generated = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        generated.notificationOccurred(type)
    }
    
}
