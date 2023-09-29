//
//  MoviesListUITests.swift
//  TMDBUITests
//
//  Created by Radwa Ahmed on 19/09/2023.
//

import XCTest
@testable import TMDB

final class MoviesListUITests: XCTestCase {
    
    var app: XCUIApplication!
    var collectionView: XCUIElement!
    
    override func setUp() {
        XCUIDevice.shared.orientation = .portrait
        self.continueAfterFailure = false
        
        self.app = XCUIApplication()
        self.app.launchArguments.append(Accessibility.appLaunchArgument.rawValue)
        self.app.launch()
        self.navigateToMoviesList()
        
        self.collectionView = self.app.collectionViews[Accessibility.MoviesListIds.collectionView.rawValue]
    }

    override func tearDown() {
        self.app = nil
        self.collectionView = nil
    }
    
}

// MARK: - Tests

extension MoviesListUITests {
    
    func test_whenMoviesListViewControllerIsDisplaying() {
        XCTAssertTrue(self.app.isDisplayingMoviesList)
    }
    
    // MARK: - Collection View Tests
    
    func test_whenMoviesCollectionViewExists() {
        XCTAssertTrue(self.collectionView.exists)
    }
    
    // MARK: - Collection View Cell Tests (Updated)
    
    func test_whenCellPosterImageIsUpdated() {
        let cell = self.getCell()
        let posterImage = cell?
            .images[Accessibility.MoviesListIds.CollectionViewCell.posterImageView.rawValue]
        XCTAssertNotNil(posterImage)
    }
    
    func test_whenCellTitleLabelIsUpdated() {
        let cell = self.getCell()
        let title = cell?
            .staticTexts[Accessibility.MoviesListIds.CollectionViewCell.titleLabel.rawValue]
            .label
        XCTAssertNotNil(title)
    }
    
    func test_whenCellDateLabelIsUpdated() {
        let cell = self.getCell()
        let date = cell?
            .staticTexts[Accessibility.MoviesListIds.CollectionViewCell.dateLabel.rawValue]
            .label
        XCTAssertNotNil(date)
    }
    
    // MARK: - Collection View Cell Tests (Tapped)
    
    func test_whenCellIsTapped() {
        let cell = self.getCell()
        cell?.tap()
        XCTAssertTrue(self.isMovieDetailsDisplayed())
    }
    
}

// MARK: - Helpers

private extension MoviesListUITests {
    
    private func navigateToMoviesList() {
        let categoriesMenuTableView = self.app.tables[Accessibility.CategoriesMenuIds.tableView.rawValue]
        let idx = Int.random(in: 0..<MovieCategory.allCases.count)
        let categoryCell = categoriesMenuTableView.cells.element(boundBy: idx)
        categoryCell.tap()
    }
    
    func getCell() -> XCUIElement? {
        let cell = self.collectionView.cells.element(boundBy: 0)
        XCTAssertNotNil(cell)
        
        return cell
    }
    
    func isMovieDetailsDisplayed() -> Bool {
        let moviesDetailsVC = self.app.otherElements[Accessibility.MovieDetailsIds.viewController.rawValue]
        let isMovieDetailsDisplayed = moviesDetailsVC.waitForExistence(timeout: 2)
        
        return isMovieDetailsDisplayed
    }
    
}
