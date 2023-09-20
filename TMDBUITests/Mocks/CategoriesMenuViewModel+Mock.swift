//
//  CategoriesMenuViewModel+Mock.swift
//  TMDBUITests
//
//  Created by Radwa Ahmed on 19/09/2023.
//

@testable import TMDB

class CategoriesMenuViewModelMock: CategoriesMenuViewModelInputProtocol {
    var isCategoryTapped = false
    func didTapOnCategory(_ category: TMDB.MovieCategory) {
        self.isCategoryTapped = true
    }
}
