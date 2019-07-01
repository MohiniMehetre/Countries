//
//  CountriesUITests.swift
//  CountriesUITests
//
//  Created by Mohini Mehetre on 28/06/19.
//  Copyright © 2019 Mohini Mehetre. All rights reserved.
//

import UIKit
import XCTest

class CountriesUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
       
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
    
    //Covers listing of all countries, search, details and save functionality
    func testForOnline_WithSave() {
        let app = XCUIApplication()
        let typeCountryNameHereSearchField = app.searchFields["Type country name here..."]
        typeCountryNameHereSearchField.tap()
        typeCountryNameHereSearchField.tap()
        let iKey = app.keys["I"]
        iKey.tap()
        
        let nKey = app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        nKey.tap()
        
        let dKey = app/*@START_MENU_TOKEN@*/.keys["d"]/*[[".keyboards.keys[\"d\"]",".keys[\"d\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        dKey.tap()
        
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["India"]/*[[".cells.staticTexts[\"India\"]",".staticTexts[\"India\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let countryDetailsNavigationBar = app.navigationBars["Country Details"]
        
        XCTAssert(app.images["Flag Image"].exists) 
        
        countryDetailsNavigationBar.buttons["Save"].tap()
        app.alerts["Alert"].buttons["OK"].tap()
        countryDetailsNavigationBar.buttons["Online Search"].tap()
        typeCountryNameHereSearchField.tap()
        app.buttons["Cancel"].tap()
    }
    
    // First set nerwork connection to OFF, before excecuting this test case
    func testForOffline() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        let onlineSearchButton = app.navigationBars["Country Details"].buttons["Online Search"]
        
        let indiaStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["India"]/*[[".cells.staticTexts[\"India\"]",".staticTexts[\"India\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        if indiaStaticText.waitForExistence(timeout: 2) {
            indiaStaticText.tap()
            onlineSearchButton.tap()
            app.searchFields["Type country name here..."].tap()
            
            let iKey = app/*@START_MENU_TOKEN@*/.keys["I"]/*[[".keyboards.keys[\"I\"]",".keys[\"I\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            iKey.tap()
            
            let nKey = app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            nKey.tap()
            
            let dKey = app/*@START_MENU_TOKEN@*/.keys["d"]/*[[".keyboards.keys[\"d\"]",".keys[\"d\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            dKey.tap()
            app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
            indiaStaticText.tap()
            onlineSearchButton.tap()
            app.buttons["Cancel"].tap()
        }
    }
}
