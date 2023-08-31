//
//  HTTPConfig.swift
//  TMDB
//
//  Created by Radwa Ahmed on 29/08/2023.
//

import Foundation

enum HTTPConfig {
    
    enum Environment {
        case production
    }

    static let environment: Environment = {
        return .production
    }()
    
    static var baseURL: String {
        
        switch environment {
        case .production:
            return "https://api.themoviedb.org/3"
        }
        
    }
    
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
}
