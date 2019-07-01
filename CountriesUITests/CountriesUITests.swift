//
//  CountriesUITests.swift
//  CountriesUITests
//
//  Created by Mohini Mehetre on 28/06/19.
//  Copyright © 2019 Mohini Mehetre. All rights reserved.
//

import UIKit
import XCTest

@testable import Countries

class CountriesUITests: XCTestCase {
    
    var viewController: CountriesSearchViewController!

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        viewController = navigationController.topViewController as? CountriesSearchViewController
        
        UIApplication.shared.keyWindow!.rootViewController = viewController
        
        let _ = navigationController.view
        let _ = viewController.view
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testForOnline_WithSave() {
        let app = XCUIApplication()
        let typeCountryNameHereSearchField = app.searchFields["Type country name here..."]
        typeCountryNameHereSearchField.tap()
        typeCountryNameHereSearchField.tap()
        let iKey = app.keys["I"]
        iKey.tap()
        
        app.keys["n"].tap()
        app.keys["d"].tap()
        
        app.buttons["Search"].tap()
        app.tables.staticTexts["India"].tap()
        
        let countryDetailsNavigationBar = app.navigationBars["Country Details"]
        countryDetailsNavigationBar.buttons["Save"].tap()
        app.alerts["Alert"].buttons["OK"].tap()
        countryDetailsNavigationBar.buttons["Online Search"].tap()
        typeCountryNameHereSearchField.tap()
        app.buttons["Cancel"].tap()
    }
    
    func testForOffline() {
//        XCTAssertTrue(viewController.isConnectedToInternet())
        
    }
}
