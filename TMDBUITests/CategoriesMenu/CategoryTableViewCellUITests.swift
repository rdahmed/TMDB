//
//  CategoryTableViewCellUITests.swift
//  TMDBUITests
//
//  Created by Radwa Ahmed on 19/09/2023.
//

import XCTest

final class CategoryTableViewCellUITests: XCTestCase {

    var app: XCUIApplication!
    var titleLabel: XCUIElement!
    
    override func setUp() {
        XCUIDevice.shared.orientation = .portrait
        self.continueAfterFailure = false
        
        self.app = XCUIApplication()
        self.app.launchArguments.append(Accessibility.appLaunchArgument.rawValue)
        self.app.launch()
    }

    override func tearDown() {
        self.app = nil
    }
    
    

}
