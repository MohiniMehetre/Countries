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
    
    private static var sharedInstance: CountriesDatabaseManager  =  {
        let countriesDatabaseManager = CountriesDatabaseManager()
        return countriesDatabaseManager
    }()
    
    // This prevents others from using the default '()' initializer for this class.
    override private init() {
        super.init()
    }
    
    // MARK:- Accessor -
    class func shared() -> CountriesDatabaseManager {
        return sharedInstance
    }

    func save(countryDetails: CountryInformation) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
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
        } catch let error as NSError {
            print("Error while storing country details in core data: \(error.userInfo)")
        }
    }
    /*
    func getLocationCount() -> Int {
        //1
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<TTICurrentLocation>(entityName: "TTICurrentLocation")
        fetchRequest.includesPropertyValues = false
        
        //3
        do {
            let count = try managedContext.count(for: fetchRequest)
            return count
        } catch {
            print(error.localizedDescription)
        }
        return 0
    }
    
    func fetchLocations() -> [TTICurrentLocation] {
        //1
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<TTICurrentLocation>(entityName: "TTICurrentLocation")
        
        //3
        // Helpers
        var result = [TTICurrentLocation]()
        
        do {
            // Execute Fetch Request
            let storeMonitoring = try managedContext.fetch(fetchRequest)
            result = storeMonitoring
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return result
    }
    
    //Delete values from table
    func deleteLocations(locations: [TTICurrentLocation]) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TTICurrentLocation")
        fetchRequest.includesPropertyValues = false // Only fetch the managedObjectID (not the full object structure)
        
        var fetchResults: [NSManagedObject] = []
        
        do {
            fetchResults = try managedContext.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        
        do {
            for result in fetchResults {
                for location in locations {
                    if (result == location) {
                        managedContext.delete(location)
                    }
                }
            }
            try managedContext.save()
        } catch let error as NSError {
            print("Error while deleting location details from core data: \(error.userInfo)")
        }
    }*/
}
