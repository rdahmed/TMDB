//
//  MoviesLocalStore.swift
//  TMDB
//
//  Created by Radwa Ahmed on 15/09/2023.
//

import Foundation

protocol MoviesLocalStoreProtocol {
    init(database: Database)
    func save(_ movie: Movie)
    func fetchAll() -> [Movie]
    func clear()
}

class MoviesLocalStore: MoviesLocalStoreProtocol {

    private let database: Database
    required init(database: Database) {
        self.database = database
    }

    func save(_ movie: Movie) {
        self.database.store(object: movie, in: .moviesList)
    }

    func fetchAll() -> [Movie] {
        return self.database.fetch(table: .moviesList, predicate: nil)
    }

    func clear() {
        self.database.delete(table: .moviesList, predicate: nil)
    }
    
}
