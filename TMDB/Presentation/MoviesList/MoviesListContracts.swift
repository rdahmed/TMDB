//
//  MoviesListContracts.swift
//  TMDB
//
//  Created by Radwa Ahmed on 01/09/2023.
//

import Foundation

protocol MoviesListViewModelInputProtocol: AnyObject {
    func fetchMovies(completion: (() -> Void)?)
    func search(completion: (() -> Void)?)
    
    func didTapOnMovie(_ id: Int)
}
