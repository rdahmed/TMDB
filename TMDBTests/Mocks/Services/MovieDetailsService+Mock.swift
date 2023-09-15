//
//  MovieDetailsService+Mock.swift
//  TMDBTests
//
//  Created by Radwa Ahmed on 15/09/2023.
//

@testable import TMDB

class MovieDetailsServiceMock: MovieDetailsServiceProtocol {
    
    var error: Error?
    
    var getDetailsCalled = false
    var details: MovieDetails?
    func getDetails(
        _ id: Int,
        completionHandler: @escaping ((Result<MovieDetails?, Error>) -> Void)
    ) {
        self.getDetailsCalled = true
        
        if let error {
            completionHandler(.failure(error))
            return
        }
        
        if let details {
            completionHandler(.success(details))
            return
        }
    }
    
    var getCreditsCalled = false
    var cast: MovieCast?
    func getCredits(
        _ id: Int,
        completionHandler: @escaping ((Result<MovieCast?, Error>) -> Void)
    ) {
        self.getCreditsCalled = true
        
        if let error {
            completionHandler(.failure(error))
            return
        }
        
        if let cast {
            completionHandler(.success(cast))
            return
        }
    }
    
    var getReviewsCalled = false
    var reviews: MovieReviews?
    func getReviews(
        _ id: Int,
        completionHandler: @escaping ((Result<MovieReviews?, Error>) -> Void)
    ) {
        self.getReviewsCalled = true
        
        if let error {
            completionHandler(.failure(error))
            return
        }
        
        if let reviews {
            completionHandler(.success(reviews))
            return
        }
    }
    
    var addRatingCalled = false
    func addRating(
        _ id: Int,
        value: Double,
        completionHandler: @escaping ((Result<Bool, Error>) -> Void)
    ) {
        self.addRatingCalled = true
        
        if let error {
            completionHandler(.failure(error))
            return
        }
        
        completionHandler(.success(true))
    }
    
    var deleteRatingCalled = false
    func deleteRating(
        _ id: Int,
        completionHandler: @escaping ((Result<Bool, Error>) -> Void)
    ) {
        self.deleteRatingCalled = true
        
        if let error {
            completionHandler(.failure(error))
            return
        }
        
        completionHandler(.success(true))
    }
    
}
