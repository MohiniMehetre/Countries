//
//  CountriesAPI.swift
//  Countries
//
//  Created by Mohini Mehetre on 28/06/19.
//  Copyright © 2019 Mohini Mehetre. All rights reserved.
//

import Foundation
import Moya

enum CountriesAPI {
    case searchCountries(name: String)
    case getAllCountries()
}

extension CountriesAPI : TargetType {
    
    var baseURL  : URL {
        return Constants.API.baseURL
    }
    
    var path:String {
        switch self {
        case let .searchCountries(name):
            return String(format: Constants.API.CountryServices.searchCountryAPIPath, name)
            
        case .getAllCountries():
            return String(format: Constants.API.CountryServices.allCountriesAPIPath)
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return Task.requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
}
