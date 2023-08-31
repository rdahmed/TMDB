//
//  String+Utilities.swift
//  TMDB
//
//  Created by Radwa Ahmed on 29/08/2023.
//

import Foundation

extension String {
    static let empty = ""
    
    func formatted(_ format: String) -> Self {
        let forrmatter = DateFormatter()
        forrmatter.dateFormat = format
        let date = forrmatter.date(from: self) ?? Date()
        
        forrmatter.dateFormat = "dd/MM/YYYY"
        return forrmatter.string(from: date)
    }
}
