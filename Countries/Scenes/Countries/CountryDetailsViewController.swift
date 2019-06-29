//
//  CountryDetailsViewController.swift
//  Countries
//
//  Created by Mohini Mehetre on 29/06/19.
//  Copyright © 2019 Mohini Mehetre. All rights reserved.
//

import UIKit

enum CountryItem: Int {
    case name, capital, callingCode, region, subRegion, timeZone, currencies, languages, totalItems
    
    var strValue: String {
        switch self {
        case .name:
            return "Name:"
        case .capital:
            return "Capital:"
        case .callingCode:
            return "Calling code:"
        case .region:
            return "Region:"
        case .subRegion:
            return "Sub region:"
        case .timeZone:
            return "Time zone:"
        case .currencies:
            return "Currencies used:"
        case .languages:
            return "Languages spoken:"
        default:
            return ""
        }
    }
}

class CountryDetailsViewController: UIViewController {

    @IBOutlet weak var countryDetailsTableView: UITableView!
    @IBOutlet weak var countryFlagImageView: UIImageView!

    var countryInformation: CountryInformation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.countryDetailsTableView.estimatedRowHeight = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ? 60 : 50

        //Load and set flag image asynchronously
        self.countryFlagImageView.setImageWithUrl(imageUrl: (countryInformation?.flag) ?? "")
    }
    
    //MARK:- IBAction methods
    @IBAction func handleSave() {
        let fileName = NSURL(fileURLWithPath: (self.countryInformation?.flag)!).lastPathComponent!
        self.countryInformation?.flag = CountriesFileManager.shared().saveFileNamed(fileName: fileName, image: self.countryFlagImageView.image!)
        
        CountriesDatabaseManager.shared().save(countryDetails: self.countryInformation!)
    }
}

// MARK: - UITableView Delegate and Datasource
extension CountryDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CountryItem.totalItems.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let value = CountryItem(rawValue: indexPath.row)!
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryDetailCell")
        
        cell!.textLabel?.text = value.strValue
        
        switch value {
        case .name:
            cell!.detailTextLabel?.text = self.countryInformation?.name
        case .capital:
            cell!.detailTextLabel?.text = self.countryInformation?.capital
        case .callingCode:
            cell!.detailTextLabel?.text = self.countryInformation?.callingCodes?.joined(separator: ", ")
        case .region:
            cell!.detailTextLabel?.text = self.countryInformation?.region
        case .subRegion:
            cell!.detailTextLabel?.text = self.countryInformation?.subregion
        case .timeZone:
            cell!.detailTextLabel?.text = self.countryInformation?.timezones?.joined(separator: ", ")
        case .currencies:
            let currencies = self.countryInformation?.currencies!.compactMap({ (currency) -> String in
                currency.name!
            })
            cell!.detailTextLabel?.text = currencies?.joined(separator: ", ")
        case .languages:
            let languages = self.countryInformation?.languages!.compactMap({ (currency) -> String in
                currency.name!
            })
            cell!.detailTextLabel?.text = languages?.joined(separator: ", ")
        default:
            print("Default")
        }
        cell!.textLabel?.textColor = UIColor.white
        cell!.detailTextLabel?.textColor = UIColor.white
        
        return cell!
    }
}
