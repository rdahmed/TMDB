//
//  MoviesListViewModelTests.swift
//  TMDBTests
//
//  Created by Radwa Ahmed on 15/09/2023.
//

import XCTest
@testable import TMDB

final class MoviesListViewModelTests: XCTestCase {
    
    let category: MovieCategory! = nil
    private var service: MoviesServiceMock!
    private var router: MoviesListRouterMock!
    
    var sut: MoviesListViewModel!
    
    override func setUp() {
        self.service = .init()
        self.router = .init()
    }
    
    override func tearDown() {
        self.service = nil
        self.router = nil
        
        self.sut = nil
    }
    
    // MARK: - Service Calls Tests
    
    func testServiceIsCalled_whenFetchNowPlayingMoviesIsCalled() {
        // Given
        self.service.nowPlayingMovies = .mock
        self.sut = .init(
            category: .nowPlaying,
            service: self.service,
            router: self.router
        )
        
        // When
        self.sut.fetchMovies { /* NOTHING TO DO HERE */ }
        
        // Assert
        XCTAssertTrue(self.service.getNowPlayingCalled)
        XCTAssertEqual(self.sut.movies, Movies.mock.movies)
    }
    
    func testServiceIsCalled_whenFetchPopularMoviesIsCalled() {
        // Given
        self.service.popularMovies = .mock
        self.sut = .init(
            category: .popular,
            service: self.service,
            router: self.router
        )
        
        // When
        self.sut.fetchMovies { /* NOTHING TO DO HERE */ }
        
        // Assert
        XCTAssertTrue(self.service.getPopularCalled)
        XCTAssertEqual(self.sut.movies, Movies.mock.movies)
    }
    
    func testServiceIsCalled_whenFetchTopRatedMoviesIsCalled() {
        // Given
        self.service.topRatedMovies = .mock
        self.sut = .init(
            category: .topRated,
            service: self.service,
            router: self.router
        )
        
        // When
        self.sut.fetchMovies { /* NOTHING TO DO HERE */ }
        
        // Assert
        XCTAssertTrue(self.service.getTopRatedCalled)
        XCTAssertEqual(self.sut.movies, Movies.mock.movies)
    }
    
    func testServiceIsCalled_whenFetchUpcomingMoviesIsCalled() {
        // Given
        self.service.upcomingMovies = .mock
        self.sut = .init(
            category: .upcoming,
            service: self.service,
            router: self.router
        )
        
        // When
        self.sut.fetchMovies { /* NOTHING TO DO HERE */ }
        
        // Assert
        XCTAssertTrue(self.service.getUpcomingCalled)
        XCTAssertEqual(self.sut.movies, Movies.mock.movies)
    }
    
    func testServiceIsCalled_whenFetchServiceIsFailed() {
        // Given
        self.service.error = ErrorMock.fakeError
        
        // When
        self.sut.fetchMovies { /* NOTHING TO DO HERE */ }
        
        // Assert
        XCTAssertEqual(self.sut.errorMessage, ErrorMock.fakeError.localizedDescription)
    }
    
    func testRouterIsCalled_whenMovieIsPressed() {
        // Given
        let selectedMovie = Movies.mock.movies[0]
        self.sut = .init(
            category: .upcoming,
            service: self.service,
            router: self.router
        )
        
        // When
        self.sut.didTapOnMovie(selectedMovie.id)
        
        // Assert
        XCTAssertTrue(self.router.showMovieDetailsCalled)
        XCTAssertEqual(self.router.selectedMovieId, selectedMovie.id)
    }
    
}
