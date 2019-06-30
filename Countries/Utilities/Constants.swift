//
//  Constants.swift
//  Countries
//
//  Created by Mohini Mehetre on 28/06/19.
//  Copyright © 2019 Mohini Mehetre. All rights reserved.
//

import UIKit

struct Constants {
    
    struct API {
        
        // Server URLs.
        static let url = "https://restcountries.eu/rest/v2" //Production
        
        // Base URL.
        static let baseURL = URL.init(string: url)!
        
        // All Country related API paths.
        struct CountryServices {
            // API path to fetch countries having specific keyword in their names.
            static let searchCountryAPIPath = "/name/%@"
            
            //API path to fetch all countries out there.
            static let allCountriesAPIPath = "/all"
        }
    }
    
    //Alerts and messages.
    static let alertTitle_Alert = "Alert"
    static let saveSuccessAlertMessage = "Country details saved successfully."
    static let saveFailedAlertMessage = "Failed to save country details. Please try again"
    static let noResultsFoundMessage = "No results found."
    static let typeToSearchCountryMessage = "Type in the above search box to search for a country."

    //Country
    static let differentCountries = "%d Different countries found"
    static let differentCountry = "%d Country found"
    
    //Segue Identifiers
    static let countryDetailViewControllerIdentifier = "countryDetailViewController"
} 
