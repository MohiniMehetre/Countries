//
//  CountryInterfaces.swift
//  Countries
//
//  Created by Mohini Mehetre on 29/06/19.
//  Copyright © 2019 Mohini Mehetre. All rights reserved.
//


import Foundation

protocol CountryBusinessLogic: class {
    /// Gives API call to fetch countries with given keyword in their names.
    /// - Parameter name: Keyword to be searched and passed as a parameter to API.
    func searchCountries(name: String)
    
    /// Gives API call to fetch all existing countries.
    func getAllCountries()
    
    /// Checks internet connection and load countries based on it. Loads from local database when offline and from server when online
    func checkConnectivityAndLoadEntries()
    
    /// This methods will search given keyword locally from given array.
    /// - Parameter name: Keyword to be searched.
    /// - Parameter countries: Array on which search criteria will be applied.
    func searchCountry(name: String, from countries: Countries) -> Countries
}

protocol CountriesViewDisplayable: class, AppDisplayable {
    /// Clears datasource array and updates view accordingly.
    func clearCountryList()
    
    /// Send the loaded countries (either from server or from local database) to the view controller for further use.
    func refreshCountryList(countries: Countries)
    
    /// Sends update to the view controller for the failed API to fetch all countries list.
    func countryListAPIFailed()
    
    /// Sends update to the view controller for the failed API to search from countries.
    func searchCountryAPIFailed()
    
    /// Countinuously listens to network connection events.
    func listenToNetworkUpdates()
    
    /// View controller will call this when search bar text changes. This will do further search operation based on the search keyword.
    func handleSearchBarTextChange(searchText: String?)
}

