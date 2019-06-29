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
    func checkConnectivityAndLoadOfflineEntries()
}

protocol CountriesViewDisplayable: class, AppDisplayable {
    func clearCountryList()
    func moveToCountryDetails()
    func refreshCountryList(countries: Countries)
    func countryListAPIFailed()
}

