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
        
        // Server URLs
        static let url = "https://restcountries.eu/rest/v2" //Production
        
        // Base URL
        static let baseURL = URL.init(string: url)!
        
        //All Country related API paths
        struct CountryServices {
            static let countryListAPIPath = "/name/%@"
        }
    }
    
    //Alerts and messages
    static let alertTitle_Alert = "Alert"
    static let saveSuccessAlertMessage = "Country details saved successfully."
    static let saveFailedAlertMessage = "Failed to save country details. Please try again"
    
    //Country
    static let differentCountries = "%d Different countries found"
    static let differentCountry = "%d Country found"
    
    //Segue Identifiers
    static let countryDetailViewControllerIdentifier = "countryDetailViewController"
} 
