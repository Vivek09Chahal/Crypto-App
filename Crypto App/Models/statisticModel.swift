//
//  statisticModel.swift
//  Crypto App
//
//  Created by Vivek Chahal on 3/30/25.
//

import Foundation

struct statisticModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil){
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}

