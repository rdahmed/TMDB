//
//  MoviesService.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation
import Combine

class MoviesService: MoviesServiceProtocol {
    private init() {}
    static let `default` = MoviesService()
    
    private let jsonTranspost = JSONTransport()
    var cancellables: Set<AnyCancellable> = []
}

extension MoviesService {
    func getNowPlaying(
        _ page: Int,
        completionHandler: @escaping ((Result<Movies?, Error>) -> Void)
    ) {
        let publisher: MoviesPublisher<MoviesDTO> = self.jsonTranspost.get(
            route: .getNowPlaying,
            queryItems: ["page" : "\(page)"]
        )
        self.storedMovies(publisher) { result in
            completionHandler(result)
        }
    }
    
    func getPopular(
        _ page: Int,
        completionHandler: @escaping ((Result<Movies?, Error>) -> Void)
    ) {
        let publisher: MoviesPublisher<MoviesDTO> = self.jsonTranspost.get(
            route: .getPopular,
            queryItems: ["page" : "\(page)"]
        )
        self.storedMovies(publisher) { result in
            completionHandler(result)
        }
    }
    
    func getTopRated(
        _ page: Int,
        completionHandler: @escaping ((Result<Movies?, Error>) -> Void)
    ) {
        let publisher: MoviesPublisher<MoviesDTO> = self.jsonTranspost.get(
            route: .getTopRated,
            queryItems: ["page" : "\(page)"]
        )
        self.storedMovies(publisher) { result in
            completionHandler(result)
        }
    }
    
    func getUpcoming(
        _ page: Int,
        completionHandler: @escaping ((Result<Movies?, Error>) -> Void)
    ) {
        let publisher: MoviesPublisher<MoviesDTO> = self.jsonTranspost.get(
            route: .getUpcoming,
            queryItems: ["page" : "\(page)"]
        )
        self.storedMovies(publisher) { result in
            completionHandler(result)
        }
    }
    
    func search(
        _ keyword: String,
        page: Int,
        completionHandler: @escaping ((Result<Movies?, Error>) -> Void)
    ) {
        let publisher: MoviesPublisher<MoviesDTO> = self.jsonTranspost.get(
            route: .search,
            queryItems: ["query": keyword, "page" : "\(page)"]
        )
        self.storedMovies(publisher) { result in
            completionHandler(result)
        }
    }
}

private extension MoviesService {
    func storedMovies(
    _ publisher: MoviesPublisher<MoviesDTO>,
    completionHandler: @escaping ((Result<Movies?, Error>) -> Void)
    ) {
        var movies: Movies?
        publisher
            .sink { completion in
            switch completion {
            case .finished:
                completionHandler(.success(movies))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        } receiveValue: { result in
            movies = Movies(dto: result)
        }
        .store(in: &cancellables)
    }
}
