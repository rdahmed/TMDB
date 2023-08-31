//
//  Optional+Unwrapped.swift
//  TMDB
//
//  Created by Radwa Ahmed on 29/08/2023.
//

import Foundation

extension Optional where Wrapped == String {
    
    var orEmpty: String {
        switch self {
        case .none:
            return .empty
        case .some(let string):
            return string
        }
    }
    
    var notNilOrEmpty: Bool {
        return !self.orEmpty.isEmpty
    }
    
    func unwrapped(_ orString: String) -> String {
        switch self {
        case .none:
            return orString
        case .some(let string):
            return string
        }
    }
    
}
