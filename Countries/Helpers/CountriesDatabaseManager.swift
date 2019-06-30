//
//  CountriesDatabaseManager.swift
//  Countries
//
//  Created by Mohini Mehetre on 29/06/19.
//  Copyright © 2019 Mohini Mehetre. All rights reserved.
//

import UIKit
import CoreData

class CountriesDatabaseManager: NSObject {
    
    /// Creates shared instance for database manager.
    private static var sharedInstance: CountriesDatabaseManager  =  {
        let countriesDatabaseManager = CountriesDatabaseManager()
        return countriesDatabaseManager
    }()
    
    // This prevents others from using the default '()' initializer for this class.
    override private init() {
        super.init()
    }
    
    /// Returns shared instance for database manager.
    class func shared() -> CountriesDatabaseManager {
        return sharedInstance
    }
    
    /// Saves country information into local database (Coredata here).
    /// - Parameter countryDetails: CountryInformation object that contains all information about the specific country.
    func save(countryDetails: CountryInformation) -> Bool {
        
        //Check whether the country information is already present. If present, delete it.
        self.deleteCountryIfExists(countryInformation: countryDetails)
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Country",
                                       in: managedContext)!
        
        //3
        let countryObj = NSManagedObject(entity: entity,
                                         insertInto: managedContext)
        
        // 4
        let callingCodesString = countryDetails.callingCodes?.joined(separator: ", ")
        
        let currencies = countryDetails.currencies!.compactMap({ (currency) -> String in
            currency.name!
        })
        let currenciesString = currencies.joined(separator: ", ")
        
        let languages = countryDetails.languages!.compactMap({ (language) -> String in
            language.name!
        })
        let languagesString = languages.joined(separator: ", ")
        
        let timeZonesString = countryDetails.timezones?.joined(separator: ", ")
        
        countryObj.setValue(countryDetails.flag, forKeyPath: "flag")
        countryObj.setValue(countryDetails.name, forKeyPath: "name")
        countryObj.setValue(countryDetails.capital, forKeyPath: "capital")
        countryObj.setValue(callingCodesString, forKeyPath: "callingCode")
        countryObj.setValue(countryDetails.name, forKeyPath: "region")
        countryObj.setValue(countryDetails.name, forKeyPath: "subRegion")
        countryObj.setValue(timeZonesString, forKeyPath: "timeZone")
        countryObj.setValue(currenciesString, forKeyPath: "currencies")
        countryObj.setValue(languagesString, forKeyPath: "languages")
        
        // 5
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Error while storing country details in core data: \(error.userInfo)")
        }
        return false
    }
    
    /// Fetches all saved countries from local database (Coredata here).
    /// - Returns: An array of CountryInformation objects.
    func fetchCountriesOffline() -> Countries {
        //1
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Country")
        
        //3
        // Helpers
        var result = [CountryInformation]()
        
        do {
            // Execute Fetch Request
            let countries = try managedContext.fetch(fetchRequest)
            
            for managedObj in countries {
                
                let name = managedObj.value(forKey: "name") as! String
                let callingCodes = (managedObj.value(forKey: "callingCode") as! String).components(separatedBy: ", ")
                let capital = managedObj.value(forKey: "capital") as! String
                let region = managedObj.value(forKey: "region") as! String
                let subRegion = managedObj.value(forKey: "subRegion") as! String
                let timezones = (managedObj.value(forKey: "timeZone") as! String).components(separatedBy: ", ")
                
                let currencyList = (managedObj.value(forKey: "currencies") as! String).components(separatedBy: ", ")
                var currencies = [Currency]()
                for currencyObj in currencyList {
                    let currency = Currency.init(code: "", name: currencyObj, symbol: "")
                    currencies.append(currency)
                }
                
                let languageList = (managedObj.value(forKey: "languages") as! String).components(separatedBy: ", ")
                var languages = [Language]()
                for languageObj in languageList {
                    let currency = Language.init(iso6391: "", iso6392: "", name: languageObj, nativeName: "")
                    languages.append(currency)
                }
                
                let flag = managedObj.value(forKey: "flag") as! String
                
                
                
                let countryInformation = CountryInformation.init(name: name,
                                                                 callingCodes: callingCodes,
                                                                 capital: capital,
                                                                 region: region,
                                                                 subregion: subRegion,
                                                                 timezones: timezones,
                                                                 currencies: currencies,
                                                                 languages: languages,
                                                                 flag: flag)
                
                result.append(countryInformation)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return result
    }
    
    /// Deletes given country from local database (Coredata here).
    /// - Parameter countryInformation: CountryInformation object that contains all information about the specific country which needs to be deleted.
    func deleteCountryIfExists(countryInformation: CountryInformation) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Country")
        fetchRequest.predicate = NSPredicate(format: "name = %@", countryInformation.name!)
        
        var fetchResults: [NSManagedObject] = []
        
        do {
            fetchResults = try managedContext.fetch(fetchRequest)
            for result in fetchResults {
                managedContext.delete(result)
            }
            try managedContext.save()
        }
        catch {
            print("Error while deleting country details from core data.")
        }
    }
}
