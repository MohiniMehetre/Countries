//
//  CountryInteractor.swift
//  Countries
//
//  Created by Mohini Mehetre on 29/06/19.
//  Copyright © 2019 Mohini Mehetre. All rights reserved.
//

import Moya

class CountryInteractor {
    
    var viewControllerRef: CountriesViewDisplayable? = nil
    
    init(viewControllerRef: CountriesViewDisplayable) {
        self.viewControllerRef = viewControllerRef
    }
}

extension CountryInteractor: CountryBusinessLogic {
    
    func searchCountry(name: String, from countries: Countries) -> Countries {
        let searchedCountries = countries.filter { (country) -> Bool in
            return (country.name?.lowercased().contains(name.lowercased()))!
        }
        return searchedCountries
    }
    
    func checkConnectivityAndLoadEntries() {
        if !(self.viewControllerRef?.isConnectedToInternet())! {
            let countries = CountriesDatabaseManager.shared().fetchCountriesOffline()
            self.viewControllerRef?.refreshCountryList(countries: countries)
        }
        else {
            self.getAllCountries()
        }
    }
    
    func searchCountries(name: String) {
        
        //show progress hud
        self.viewControllerRef?.showActivity(with: "Fetching...")
        
        MoyaProvider<CountriesAPI>().request(.searchCountries(name: name)) { result in
            
            //hide progress hud
            self.viewControllerRef?.hideActivity()
            
            switch result {
            //TODO:- make generic solution for error handling
            case let .success(response) :
                
                if case 200..<400 = response.statusCode {
                    do {
                        // data we are getting from network request
                        let decoder = JSONDecoder()
                        let countries = try decoder.decode(Countries.self, from: response.data)
                        self.viewControllerRef?.refreshCountryList(countries: countries)
                    }
                    catch let error {
                        self.viewControllerRef?.searchCountryAPIFailed()
                        self.viewControllerRef?.showAlert(title: Constants.alertTitle_Alert, message: error.localizedDescription)
                    }
                }
                else {
                    self.viewControllerRef?.searchCountryAPIFailed()
                }
                
            case let .failure(error):
                self.viewControllerRef?.searchCountryAPIFailed()
                self.viewControllerRef?.showAlert(title: Constants.alertTitle_Alert, message: error.localizedDescription)            }
        }
    }
    
    func getAllCountries() {
        
        //show progress hud
        self.viewControllerRef?.showActivity(with: "Fetching...")
        
        MoyaProvider<CountriesAPI>().request(.getAllCountries()) { result in
            
            //hide progress hud
            self.viewControllerRef?.hideActivity()
            
            switch result {
            //TODO:- make generic solution for error handling
            case let .success(response) :
                
                if case 200..<400 = response.statusCode {
                    do {
                        // data we are getting from network request
                        let decoder = JSONDecoder()
                        let countries = try decoder.decode(Countries.self, from: response.data)
                        self.viewControllerRef?.refreshCountryList(countries: countries)
                    }
                    catch let error {
                        self.viewControllerRef?.countryListAPIFailed()
                        self.viewControllerRef?.showAlert(title: Constants.alertTitle_Alert, message: error.localizedDescription)
                    }
                }
                else {
                    self.viewControllerRef?.countryListAPIFailed()
                }
                
            case let .failure(error):
                self.viewControllerRef?.countryListAPIFailed()
                self.viewControllerRef?.showAlert(title: Constants.alertTitle_Alert, message: error.localizedDescription)            }
        }
    }
}
