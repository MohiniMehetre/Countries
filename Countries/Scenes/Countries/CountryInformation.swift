//
//  CountryInformation.swift
//  Countries
//
//  Created by Mohini Mehetre on 29/06/19.
//  Copyright © 2019 Mohini Mehetre. All rights reserved.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let countryInformation = try? newJSONDecoder().decode(CountryInformation.self, from: jsonData)

import Foundation

// MARK: - CountryInformation
struct CountryInformation: Codable {
    let name: String?
    let callingCodes: [String]?
    let capital: String?
    let region, subregion: String?
    let timezones: [String]?
    let currencies: [Currency]?
    let languages: [Language]?
    var flag: String?
}

// MARK: - Currency
struct Currency: Codable {
    let code, name, symbol: String?
}

// MARK: - Language
struct Language: Codable {
    let iso6391, iso6392, name, nativeName: String?
    
    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso639_1"
        case iso6392 = "iso639_2"
        case name, nativeName
    }
}

typealias Countries = [CountryInformation]
