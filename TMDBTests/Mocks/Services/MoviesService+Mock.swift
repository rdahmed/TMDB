//
//  MoviesService+Mock.swift
//  TMDBTests
//
//  Created by Radwa Ahmed on 15/09/2023.
//

@testable import TMDB

class MoviesServiceMock: MoviesServiceProtocol {
    
    var error: Error?
    
    var getNowPlayingCalled = false
    var nowPlayingMovies: Movies?
    func getNowPlaying(
        _ page: Int,
        completionHandler: @escaping ((Result<Movies?, Error>) -> Void)
    ) {
        self.getNowPlayingCalled = true
        
        if let error {
            completionHandler(.failure(error))
        }
        
        if let nowPlayingMovies {
            completionHandler(.success(nowPlayingMovies))
        }
    }
    
    var getPopularCalled = false
    var popularMovies: Movies?
    func getPopular(
        _ page: Int,
        completionHandler: @escaping ((Result<Movies?, Error>) -> Void)
    ) {
        self.getPopularCalled = true
        
        if let error {
            completionHandler(.failure(error))
        }
        
        if let popularMovies {
            completionHandler(.success(popularMovies))
        }
    }
    
    var getTopRatedCalled = false
    var topRatedMovies: Movies?
    func getTopRated(
        _ page: Int,
        completionHandler: @escaping ((Result<Movies?, Error>) -> Void)
    ) {
        self.getTopRatedCalled = true
        
        if let error {
            completionHandler(.failure(error))
        }
        
        if let topRatedMovies {
            completionHandler(.success(topRatedMovies))
        }
    }
    
    var getUpcomingCalled = false
    var upcomingMovies: Movies?
    func getUpcoming(
        _ page: Int,
        completionHandler: @escaping ((Result<Movies?, Error>) -> Void)
    ) {
        self.getUpcomingCalled = true
        
        if let error {
            completionHandler(.failure(error))
        }
        
        if let upcomingMovies {
            completionHandler(.success(upcomingMovies))
        }
    }
    
    var searchCalled = false
    var filteredMovies: Movies?
    func search(
        _ keyword: String,
        page: Int,
        completionHandler: @escaping ((Result<Movies?, Error>) -> Void)
    ) {
        self.searchCalled = true
        
        if let error {
            completionHandler(.failure(error))
        }
        
        if let filteredMovies {
            completionHandler(.success(filteredMovies))
        }
    }
    
}
