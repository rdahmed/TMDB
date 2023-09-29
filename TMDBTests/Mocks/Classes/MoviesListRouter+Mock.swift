//
//  MoviesListRouter+Mock.swift
//  TMDBTests
//
//  Created by Radwa Ahmed on 15/09/2023.
//

@testable import TMDB

class MoviesListRouterMock: MoviesListRouter {
    
    var showMovieDetailsCalled = false
    var selectedMovieId: Int?
    
    func showMovieDetails(_ id: Int) {
        self.showMovieDetailsCalled = true
        self.selectedMovieId = id
    }
    
}
