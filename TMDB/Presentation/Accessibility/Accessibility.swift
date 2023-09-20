//
//  Accessibility.swift
//  TMDB
//
//  Created by Radwa Ahmed on 19/09/2023.
//

import Foundation

public enum Accessibility: String {
    case appLaunchArgument = "--uitesting"
    
    enum CategoriesMenuIds: String {
        case viewController = "categoriesVC"
        case tableView = "categoriesTV"
        case tableViewCell = "categoryTVC"
        case tableViewCellTitleLabel = "categoryTVCTitleLabel"
    }
    
    enum MoviesListIds: String {
        case viewController = "moviesVC"
        case collectionView = "moviesCV"
        case collectionViewCell = "movieCVC"
    }
}
