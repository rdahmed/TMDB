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
    
    override func setUp() {
        XCUIDevice.shared.orientation = .portrait
        self.continueAfterFailure = false
        
        self.app = XCUIApplication()
        self.app.launchArguments.append(Accessibility.appLaunchArgument.rawValue)
    }

    override func tearDown() {
        self.app = nil
    }
    
}
