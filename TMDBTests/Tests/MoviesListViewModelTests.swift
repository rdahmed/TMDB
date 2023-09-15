//
//  MoviesListViewModelTests.swift
//  TMDBTests
//
//  Created by Radwa Ahmed on 15/09/2023.
//

import XCTest
@testable import TMDB

final class MoviesListViewModelTests: XCTestCase {
    
    let category: MovieCategory!
    private let service: MoviesServiceMock!
    private let router: MoviesListRouterMock!
    
    var sut: MoviesListViewModel!
    
    override func setUp() {
        self.service = .init()
        self.router = .init()
        
        self.sut = .init(
            category: .nowPlaying,
            service: self.service,
            router: self.router
        )
    }
    
    override func tearDown() {
        self.service = nil
        self.router = nil
        
        self.sut = nil
    }
    
    // MARK: - Service Calls Tests
    
    func testServiceIsCalled_whenFetchMoviesIsCalled() {
        // Given
        switch self.category {
        case .popular:
            self.service.popularMovies = .mock
        case .nowPlaying:
            self.service.nowPlayingMovies = .mock
        case .upcoming:
            self.service.upcomingMovies = .mock
        case .topRated:
            self.service.topRatedMovies = .mock
        }
        
        // When
        self.sut.fetchMovies { /* NOTHING TO DO HERE */ }
        
        // Assert
        XCTAssertTrue(self.service.getNowPlayingCalled)
        XCTAssertEqual(self.sut.nowPlayingMovies, .mock)
    }
    
}
