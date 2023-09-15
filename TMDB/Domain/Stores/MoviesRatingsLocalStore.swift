//
//  MoviesRatingsLocalStore.swift
//  TMDB
//
//  Created by Radwa Ahmed on 15/09/2023.
//

import Foundation

class MoviesRatingsLocalStore {
    
    private enum Constants {
        static let ratingsKey = "ratingsKey"
    }
    
    private init() {}
    static let `default`: MoviesRatingsLocalStore = MoviesRatingsLocalStore()
    
    private let storage = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    var ratings: [Int: Double] {
        set {
            let encoded = try? self.encoder.encode(newValue)
            self.storage.set(encoded, forKey: Constants.ratingsKey)
        }
        get {
            guard let encoded = self.storage.object(forKey: Constants.ratingsKey) as? Data else { return [:] }
            
            let ratings = try? self.decoder.decode([Int: Double].self, from: encoded)
            return ratings ?? [:]
        }
    }
    
}
