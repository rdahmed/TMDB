//
//  CategoriesMenuContracts.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

enum MovieCategory: Int, CaseIterable {
    case popular = 0
    case nowPlaying
    case upcoming
    case topRated
}

protocol CategoriesMenuViewModelInputProtocol: AnyObject {
    var categories: [MovieCategory] { get }
    func didTapOnCategory(_ category: MovieCategory)
}

extension CategoriesMenuViewModelInputProtocol {
    var categories: [MovieCategory] { return MovieCategory.allCases }
}
