//
//  CountryInterfaces.swift
//  Countries
//
//  Created by Mohini Mehetre on 29/06/19.
//  Copyright © 2019 Mohini Mehetre. All rights reserved.
//


import Foundation

protocol CountryBusinessLogic: class {
    func searchCountries(name: String)
    func getAllCountries()
    func checkConnectivityAndLoadEntries()
    func searchCountry(name: String, from countries: Countries) -> Countries
}

protocol CountriesViewDisplayable: class, AppDisplayable {
    func clearCountryList()
    func refreshCountryList(countries: Countries)
    func countryListAPIFailed()
    func searchCountryAPIFailed()
    func listenToNetworkUpdates()
    func handleSearchBarTextChange(searchText: String?)
}

