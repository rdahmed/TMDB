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
        
        enum TableViewCell: String {
            case contentView = "categoryTVC"
            case titleLabel = "categoryTVCTitleLabel"
        }
    }
    
    enum MoviesListIds: String {
        case viewController = "moviesVC"
        case collectionView = "moviesCV"
        
        enum CollectionViewCell: String {
            case contentView = "movieCVC"
            case posterImageView = "moviesCVCPosterImageView"
            case titleLabel = "moviesCVCTitleLabel"
            case dateLabel = "moviesCVCDateLabel"
        }
    }
    
    enum MovieDetailsIds: String {
        case viewController = "movieDetailsVC"
        case ratingView = "movieDetailsRatingView"
        case tableView = "movieDetailsTV"
        
        enum PosterTableViewCell: String {
            case contentView = "movieDetailsPosterTVC"
            case backdropImageView = "movieDetailsPosterTVCBackdropImageView"
            case posterImageView = "movieDetailsPosterTVCPosterImageView"
            case titleLabel = "movieDetailsPosterTVCTitleLabel"
            case detailsLabel = "movieDetailsPosterTVCDetailsLabel"
            case userScoreLabel = "movieDetailsPosterTVCUserScoreLabel"
            case ratingButton = "movieDetailsPosterTVCRatingButton"
        }
        
        enum OverviewTableViewCell: String {
            case contentView = "movieDetailsOverviewTVC"
            case overviewLabel = "movieDetailsOverviewTVCOverviewLabel"
        }
    }
}
