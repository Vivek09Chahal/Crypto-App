//
//  string.swift
//  Crypto App
//
//  Created by Vivek Chahal on 4/2/25.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
