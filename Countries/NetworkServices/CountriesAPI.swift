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
}

extension CountriesAPI : TargetType {
    
    var baseURL  : URL {
        return Constants.API.baseURL
    }
    
    var path:String {
        
        switch self {
            
        case let .searchCountries(name):
            let path = String(format: Constants.API.CountryServices.countryListAPIPath, name)
            return path
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
