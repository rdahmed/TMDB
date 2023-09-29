//
//  MovieDetailsUITests.swift
//  TMDBUITests
//
//  Created by Radwa Ahmed on 29/09/2023.
//

import XCTest
@testable import TMDB

final class MovieDetailsUITests: XCTestCase {

    var app: XCUIApplication!
    var tableView: XCUIElement!
    
    override func setUp() {
        XCUIDevice.shared.orientation = .portrait
        self.continueAfterFailure = false
        
        self.app = XCUIApplication()
        self.app.launchArguments.append(Accessibility.appLaunchArgument.rawValue)
        self.app.launch()
        self.navigateToMovieDetails()
        
        self.tableView = self.app.tables[Accessibility.MovieDetailsIds.tableView.rawValue]
    }
    
    override func tearDown() {
        self.app = nil
        self.tableView = nil
    }
    
}

// MARK: - Tests

extension MovieDetailsUITests {
    
    func test_whenMovieDetailsViewControllerIsDisplaying() {
        XCTAssertTrue(self.app.isDisplayingMovieDetails)
    }
    
    // MARK: - Table View Tests
    
    func test_whenDetailsTableViewExists() {
        XCTAssertTrue(self.tableView.exists)
    }
    
    // MARK: - Poster Table View Cell
    
    func test_whenPosterCellBackdropImageViewIsUpdated() {
        let image = self.app
            .images[Accessibility.MovieDetailsIds.PosterTableViewCell.backdropImageView.rawValue]
        XCTAssertNotNil(image)
    }
    
    func test_whenPosterCellPosterImageViewIsUpdated() {
        let image = self.app
            .images[Accessibility.MovieDetailsIds.PosterTableViewCell.posterImageView.rawValue]
        XCTAssertNotNil(image)
    }
    
    func test_whenPosterCellTitleLabelIsUpdated() {
        let title = self.app
            .staticTexts[Accessibility.MovieDetailsIds.PosterTableViewCell.titleLabel.rawValue]
            .label
        
        XCTAssertNotNil(title)
    }
    
    func test_whenPosterCellDetailsLabelIsUpdated() {
        let details = self.app
            .staticTexts[Accessibility.MovieDetailsIds.PosterTableViewCell.detailsLabel.rawValue]
            .label
        XCTAssertNotNil(details)
    }
    
    func test_whenPosterCellUserScoreLabelIsUpdated() {
        let userScore = self.app
            .staticTexts[Accessibility.MovieDetailsIds.PosterTableViewCell.userScoreLabel.rawValue]
            .label
        XCTAssertNotNil(userScore)
        XCTAssertEqual(userScore, "User\nScore")
    }
    
    func test_whenPosterCellRatingButtonIsTapped() {
        let button = self.app
            .buttons[Accessibility.MovieDetailsIds.PosterTableViewCell.ratingButton.rawValue]
        XCTAssertNotNil(button)
        
        button.tap()
        XCTAssertTrue(self.isRatingViewDisplayed())
    }
    
    // MARK: - Overview Table View Cell
    
    func test_whenOverviewCellOverviewLabelIsUpdated() {
        let overview = self.app
            .staticTexts[Accessibility.MovieDetailsIds.OverviewTableViewCell.overviewLabel.rawValue]
            .label
        XCTAssertNotNil(overview)
    }
    
}

// MARK: - Helpers

private extension MovieDetailsUITests {
    
    func navigateToMovieDetails() {
        let categoriesMenuTableView = self.app.tables[Accessibility.CategoriesMenuIds.tableView.rawValue]
        let idx = Int.random(in: 0..<MovieCategory.allCases.count)
        let categoryCell = categoriesMenuTableView.cells.element(boundBy: idx)
        categoryCell.tap()
        
        let moviesCollectionView = self.app.collectionViews[Accessibility.MoviesListIds.collectionView.rawValue]
        let movieCell = moviesCollectionView.cells.element(boundBy: 0)
        movieCell.tap()
    }
    
    func isRatingViewDisplayed() -> Bool {
        let ratingView = self.app.otherElements[Accessibility.MovieDetailsIds.ratingView.rawValue]
        let isRatingViewDisplayed = ratingView.waitForExistence(timeout: 2)
        
        return isRatingViewDisplayed
    }
    
}
