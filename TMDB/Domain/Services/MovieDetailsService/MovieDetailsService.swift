//
//  MovieDetailsService.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation
import Combine

class MovieDetailsService: MovieDetailsServiceProtocol {
    private init() {}
    static let `default` = MovieDetailsService()
    
    private let jsonTranspost = JSONTransport()
    var cancellables: Set<AnyCancellable> = []
}

extension MovieDetailsService {
    func getDetails(
        _ id: Int,
        completionHandler: @escaping ((Result<MovieDetails?, Error>) -> Void)
    ) {
        let publisher: MoviesPublisher<MovieDetailsDTO> = self.jsonTranspost.get(
            route: .getDetails(id: "\(id)")
        )
        self.storedMovieDetails(publisher) { result in
            completionHandler(result)
        }
    }
    
    func getSimilar(
        to id: Int,
        completionHandler: @escaping ((Result<MovieDetails?, Error>) -> Void)
    ) {
        let publisher: MoviesPublisher<MovieDetailsDTO> = self.jsonTranspost.get(
            route: .getSimilar(id: "\(id)")
        )
        self.storedMovieDetails(publisher) { result in
            completionHandler(result)
        }
    }
    
    func getCredits(
        _ id: Int,
        completionHandler: @escaping ((Result<MovieCast?, Error>) -> Void)
    ) {
        let publisher: MoviesPublisher<MovieCreditsDTO> = self.jsonTranspost.get(
            route: .getCredits(id: "\(id)")
        )
        self.storedMovieCredits(publisher) { result in
            completionHandler(result)
        }
    }
    
    func getReviews(
        _ id: Int,
        completionHandler: @escaping ((Result<MovieReviews?, Error>) -> Void)
    ) {
        let publisher: MoviesPublisher<MovieReviewsDTO> = self.jsonTranspost.get(
            route: .getReviews(id: "\(id)")
        )
        self.storedMovieReviews(publisher) { result in
            completionHandler(result)
        }
    }
    
    func addRating(
        _ id: Int,
        value: Double,
        completionHandler: @escaping ((Result<Bool, Error>) -> Void)
    ) {
        let publisher: MoviesPublisher<MovieRatingDTO> = self.jsonTranspost.post(
            route: .addRating(id: "\(id)"),
            headers: ["Content-Type": "application/json;charset=utf-8"],
            params: ["value": "\(value)"]
        )
        self.storedMovieRating(publisher) { result in
            completionHandler(result)
        }
    }
    
    func deleteRating(
        _ id: Int,
        completionHandler: @escaping ((Result<Bool, Error>) -> Void)
    ) {
        let publisher: MoviesPublisher<MovieRatingDTO> = self.jsonTranspost.delete(
            route: .deleteRating(id: "\(id)"),
            headers: ["Content-Type": "application/json;charset=utf-8"]
        )
        self.storedMovieRating(publisher) { result in
            completionHandler(result)
        }
    }
}

extension MovieDetailsService {
    func storedMovieDetails(
    _ publisher: MoviesPublisher<MovieDetailsDTO>,
    completionHandler: @escaping ((Result<MovieDetails?, Error>) -> Void)
    ) {
        var details: MovieDetails?
        publisher
            .sink { completion in
            switch completion {
            case .finished:
                completionHandler(.success(details))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        } receiveValue: { result in
            details = MovieDetails(dto: result)
        }
        .store(in: &cancellables)
    }
    
    func storedMovieCredits(
    _ publisher: MoviesPublisher<MovieCreditsDTO>,
    completionHandler: @escaping ((Result<MovieCast?, Error>) -> Void)
    ) {
        var cast: MovieCast?
        publisher
            .sink { completion in
            switch completion {
            case .finished:
                completionHandler(.success(cast))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        } receiveValue: { result in
            cast = result.cast.map { MovieCastMember(dto: $0) }
        }
        .store(in: &cancellables)
    }
    
    func storedMovieReviews(
    _ publisher: MoviesPublisher<MovieReviewsDTO>,
    completionHandler: @escaping ((Result<MovieReviews?, Error>) -> Void)
    ) {
        var reviews: MovieReviews?
        publisher
            .sink { completion in
            switch completion {
            case .finished:
                completionHandler(.success(reviews))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        } receiveValue: { result in
            reviews = MovieReviews(dto: result)
        }
        .store(in: &cancellables)
    }
    
    func storedMovieRating(
    _ publisher: MoviesPublisher<MovieRatingDTO>,
    completionHandler: @escaping ((Result<Bool, Error>) -> Void)
    ) {
        var success = false
        publisher
            .sink { completion in
            switch completion {
            case .finished:
                completionHandler(.success(success))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        } receiveValue: { result in
            success = result.success
        }
        .store(in: &cancellables)
    }
}
