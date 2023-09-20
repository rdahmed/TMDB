//
//  CategoriesMenuUITests.swift
//  TMDBUITests
//
//  Created by Radwa Ahmed on 19/09/2023.
//

import XCTest
@testable import TMDB

//final class CategoriesMenuUITests: XCTestCase {
//
//    var viewModel: CategoriesMenuViewModelMock!
//    var sut: CategoriesMenuViewController!
//
//    override func setUp() {
//        XCUIDevice.shared.orientation = .portrait
//        self.continueAfterFailure = false
//
//        self.viewModel = .init()
//        self.sut = .init(viewModel: self.viewModel)
//    }
//
//    override func tearDown() {
//        self.viewModel = nil
//        self.sut = nil
//    }
//
//}

final class CategoriesMenuUITests: XCTestCase {

    var app: XCUIApplication!
    var tableView: XCUIElement!

    override func setUp() {
        XCUIDevice.shared.orientation = .portrait
        self.continueAfterFailure = false

        self.app = XCUIApplication()
        self.app.launchArguments.append(Accessibility.appLaunchArgument.rawValue)
        self.app.launch()

        self.tableView = self.app.tables[Accessibility.CategoriesMenuIds.tableView.rawValue]
    }

    override func tearDown() {
        self.app = nil
        self.tableView = nil
    }

    // MARK: - View Controller Tests

    func test_whenCategoriesMenuViewControllerIsDisplaying() {
        XCTAssertTrue(self.app.isDisplayingCategoriesMenu)
    }

    // MARK: - Table View Tests

    func test_whenCategoriesMenuTableViewExists() {
        XCTAssertTrue(self.tableView.exists)
        XCTAssertTrue(self.tableView.cells.count == MovieCategory.allCases.count)
    }

    // MARK: - Table View Cell Tests (Appearance)

    

    // MARK: - Table View Cell Tests (Tapped)

    func test_whenPopularCellIsTapped() {
        self.tapCategoryCell(.popular)
        XCTAssertTrue(self.isMoviesListDisplayed())
    }

    func test_whenNowPlayingCellIsTapped() {
        self.tapCategoryCell(.nowPlaying)
        XCTAssertTrue(self.isMoviesListDisplayed())
    }

    func test_whenUpcomingCellIsTapped() {
        self.tapCategoryCell(.upcoming)
        XCTAssertTrue(self.isMoviesListDisplayed())
    }

    func test_whenTopRatedCellIsTapped() {
        self.tapCategoryCell(.topRated)
        XCTAssertTrue(self.isMoviesListDisplayed())
    }

    // MARK: - Helpers

    private func tapCategoryCell(_ category: MovieCategory) {
        let cell = self.getCell(category)
        cell?.tap()
    }

    private func getCell(_ category: MovieCategory) -> XCUIElement? {
        guard
            let idx = MovieCategory.allCases.firstIndex(of: category)
        else { return nil }

        let cell = self.tableView.cells.element(boundBy: idx)
        XCTAssertNotNil(cell)

        return cell
    }

    private func isMoviesListDisplayed() -> Bool {
        let moviesListVC = self.app.otherElements[Accessibility.MoviesListIds.viewController.rawValue]
        let isMoviesListDisplayed = moviesListVC.waitForExistence(timeout: 2)

        return isMoviesListDisplayed
    }

}
