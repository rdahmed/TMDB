//
//  XCUIApplication+Elements.swift
//  TMDBUITests
//
//  Created by Radwa Ahmed on 19/09/2023.
//

import XCTest
@testable import TMDB

extension XCUIApplication {
    var isDisplayingCategoriesMenu: Bool {
        return self.otherElements[
            Accessibility.CategoriesMenuIds.viewController.rawValue
        ].exists
    }
    
    var isDisplayingMoviesList: Bool {
        return self.otherElements[
            Accessibility.MoviesListIds.viewController.rawValue
        ].exists
    }
}
