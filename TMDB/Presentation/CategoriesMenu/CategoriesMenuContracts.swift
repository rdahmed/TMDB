//
//  CategoriesMenuContracts.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

protocol CategoriesMenuViewModelInputProtocol: AnyObject {
    var categories: [MovieCategory] { get }
    func didTapOnCategory(_ category: MovieCategory)
}

extension CategoriesMenuViewModelInputProtocol {
    var categories: [MovieCategory] { return MovieCategory.allCases }
}
