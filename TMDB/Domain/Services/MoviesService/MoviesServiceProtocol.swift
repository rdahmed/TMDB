//
//  MoviesServiceProtocol.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

protocol MoviesServiceProtocol {
    func getNowPlaying() -> MoviesPublisher<MoviesDTO>
    func getPopular() -> MoviesPublisher<MoviesDTO>
    func getTopRated() -> MoviesPublisher<MoviesDTO>
    func getUpcoming() -> MoviesPublisher<MoviesDTO>
    func getSimilar(to id: Int) -> MoviesPublisher<MoviesDTO>
    func search(_ keyword: String) -> MoviesPublisher<MoviesDTO>
}
