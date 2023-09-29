//
//  MovieDetailsViewModelTests.swift
//  TMDBTests
//
//  Created by Radwa Ahmed on 19/09/2023.
//

import XCTest
@testable import TMDB

final class MovieDetailsViewModelTests: XCTestCase {
    
    private var movieId: Int!
    private var service: MovieDetailsServiceMock!
    private var router: MovieDetailsRouterMock!
    
    var sut: MovieDetailsViewModel!

    override func setUp() {
        self.movieId = 502356
        self.service = .init()
        self.router = .init()
        
        self.sut = .init(
            movieId: self.movieId,
            service: self.service,
            router: self.router
        )
    }

    override func tearDown() {
        self.movieId = nil
        self.service = nil
        self.router = nil
        
        self.sut = nil
    }
    
    // MARK: - Service Calls Tests (Success)
    
    func testServiceIsCalled_whenFetchDetailsIsCalled() {
        // Given
        self.service.details = .mock
        
        // When
        self.sut.fetchDetails()
        
        // Asset
        XCTAssertTrue(self.service.getDetailsCalled == true)
        XCTAssertEqual(self.sut.details, MovieDetails.mock)
    }
    
    func testServiceIsCalled_whenFetchCreditsIsCalled() {
        // Given
        self.service.cast = .mock
        
        // When
        self.sut.fetchCredits()
        
        // Asset
        XCTAssertTrue(self.service.getCreditsCalled == true)
        XCTAssertEqual(self.sut.cast, MovieCast.mock)
    }
    
    func testServiceIsCalled_whenFetchReviewsIsCalled() {
        // Given
        self.service.reviews = .mock
        
        // When
        self.sut.fetchReviews()
        
        // Asset
        XCTAssertTrue(self.service.getReviewsCalled == true)
        XCTAssertEqual(self.sut.reviews, MovieReviews.mock.reviews)
    }
    
    func testServiceIsCalled_whenAddRateIsCalled() {
        // Given
        let rating: Double = 5
        
        // When
        self.sut.addRating(rating)
        
        // Asset
        XCTAssertTrue(self.service.addRatingCalled == true)
        XCTAssertEqual(self.sut.rating, rating)
    }
    
    func testServiceIsCalled_whenDeleteRateIsCalled() {
        // When
        self.sut.deleteRating()
        
        // Asset
        XCTAssertTrue(self.service.deleteRatingCalled == true)
        XCTAssertEqual(self.sut.rating, nil)
    }
    
    // MARK: - Service Calls Tests (Failure)
    
    func testServiceIsCalled_whenFetchDetailsIsFailed() {
        // Given
        self.service.error = ErrorMock.fakeError
        
        // When
        self.sut.fetchDetails()
        
        // Asset
        XCTAssertEqual(self.sut.errorMessage, ErrorMock.fakeError.localizedDescription)
    }
    
    func testServiceIsCalled_whenFetchCreditsIsFailed() {
        // Given
        self.service.error = ErrorMock.fakeError
        
        // When
        self.sut.fetchCredits()
        
        // Asset
        XCTAssertEqual(self.sut.errorMessage, ErrorMock.fakeError.localizedDescription)
    }
    
    func testServiceIsCalled_whenFetchReviewsIsFailed() {
        // Given
        self.service.error = ErrorMock.fakeError
        
        // When
        self.sut.fetchReviews()
        
        // Asset
        XCTAssertEqual(self.sut.errorMessage, ErrorMock.fakeError.localizedDescription)
    }
    
    func testServiceIsCalled_whenAddRateIsFailed() {
        // Given
        self.service.error = ErrorMock.fakeError
        
        // When
        self.sut.addRating(5)
        
        // Asset
        XCTAssertEqual(self.sut.errorMessage, ErrorMock.fakeError.localizedDescription)
    }
    
    func testServiceIsCalled_whenDeleteRateIsFailed() {
        // Given
        self.service.error = ErrorMock.fakeError
        
        // When
        self.sut.deleteRating()
        
        // Asset
        XCTAssertEqual(self.sut.errorMessage, ErrorMock.fakeError.localizedDescription)
    }

}
