//
//  CountriesTests.swift
//  CountriesTests
//
//  Created by Mohini Mehetre on 28/06/19.
//  Copyright © 2019 Mohini Mehetre. All rights reserved.
//

import XCTest
import Moya
@testable import Countries

class CountriesTests: XCTestCase {

       var viewController: CountriesSearchViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
//        let nav = UIApplication.shared.windows[0].rootViewController as? UINavigationController
//        viewController = nav?.viewControllers[0] as? CountriesSearchViewController
    
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "countriesSearchViewControllerIdentifier") as? CountriesSearchViewController
        UIApplication.shared.windows[0].rootViewController = viewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWhenConnectedToInternet() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(viewController.isConnectedToInternet(), "Not connected to internet")
        
        let expectation = XCTestExpectation(description: "Countries found")
        
        MoyaProvider<CountriesAPI>().request(.getAllCountries()) { result in
                
                switch result {
                //TODO:- make generic solution for error handling
                case let .success(response) :
                    
                    if case 200..<400 = response.statusCode {
                        do {
                            // data we are getting from network request
                            let decoder = JSONDecoder()
                            let countries = try decoder.decode(Countries.self, from: response.data)
                            XCTAssertNotNil(countries)
                            expectation.fulfill()
                        }
                        catch _ {
                            XCTFail()
                        }
                    }
                    else {
                        XCTFail()
                    }
                    
                case .failure(_):
                    XCTFail()
                }
            }

        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 15.0)
    }
    
    //Consider a fresh app start
    func testWhenNotConnectedToInternetAndNoSavedEntries() {
        XCTAssertFalse(viewController.isConnectedToInternet(), "Connected to internet")
        viewController.interactor = CountryInteractor(viewControllerRef: viewController)
        viewController.interactor?.checkConnectivityAndLoadEntries()
        wait(for: 1)
        XCTAssertNotNil(viewController.countries)
        XCTAssertEqual(viewController.countries?.count ?? 0, 0, "Country are saved")
    }
    
    //Consider a fresh app start
    func testWhenNotConnectedToInternetAndContainsSavedEntries() {
        XCTAssertFalse(viewController.isConnectedToInternet(), "Connected to internet")
        viewController.interactor = CountryInteractor(viewControllerRef: viewController)
        viewController.interactor?.checkConnectivityAndLoadEntries()
        wait(for: 1)
        XCTAssertNotNil(viewController.countries)
        XCTAssertGreaterThan(viewController.countries?.count ?? 0, 0, "Country not saved")
    }
    
    func testSearchValidCountryWhenOnline() {
        // get all countries
        viewController.interactor = CountryInteractor(viewControllerRef: viewController)
        viewController.interactor?.getAllCountries()
        wait(for: 5)
        XCTAssertNotNil(viewController.countries)
        
        // Check for valid country
        XCTAssertNil(viewController.searchedCountries)
        viewController.searchedCountries = viewController.interactor?.searchCountry(name: "Ind", from: viewController.countries!)
        XCTAssertNotNil(viewController.searchedCountries)
        XCTAssertGreaterThan(viewController.searchedCountries?.count ?? 0, 0, "Country not found")
    }
    
    func testSearchInvalidCountryWhenOnline() {
        // get all countries
        viewController.interactor = CountryInteractor(viewControllerRef: viewController)
        viewController.interactor?.getAllCountries()
        wait(for: 5)
        XCTAssertNotNil(viewController.countries)
        
        //check for invalid countries
        XCTAssertNil(viewController.searchedCountries)
        viewController.searchedCountries = viewController.interactor?.searchCountry(name: "xyz", from: viewController.countries!)
        XCTAssertNotNil(viewController.searchedCountries)
        XCTAssertEqual(viewController.searchedCountries?.count ?? 0, 0)
    }
    
    func testSearchPerformance() {
        
        viewController.interactor = CountryInteractor(viewControllerRef: viewController)
        viewController.interactor?.getAllCountries()
        wait(for: 5)
        XCTAssertNotNil(viewController.countries)

        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            
            // Check for valid country
            viewController.searchedCountries = viewController.interactor?.searchCountry(name: "Ind", from: viewController.countries!)
            XCTAssertNotNil(viewController.searchedCountries)
        }
    }
    
}

extension XCTestCase {
    
    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Waiting")
        
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        
        // We use a buffer here to avoid flakiness with Timer on CI
        waitForExpectations(timeout: duration + 0.5)
    }
}
