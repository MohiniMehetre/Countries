//
//  CountriesSearchViewController.swift
//  Countries
//
//  Created by Mohini Mehetre on 29/06/19.
//  Copyright © 2019 Mohini Mehetre. All rights reserved.
//

import UIKit

class CountriesSearchViewController: UIViewController {
    
    lazy var interactor :CountryBusinessLogic? = CountryInteractor(viewControllerRef: self)
    
    @IBOutlet weak var countriesTableView: UITableView!
    @IBOutlet weak var countriesCountLabel: UILabel!
    @IBOutlet weak var noRecordsFoundLabel: UILabel!
    
    var countries: Countries?
    
    var searchController: UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initializeView()
    }
    
    // MARK:- Private Methods
    func initializeView() {
        
        //UI related stuff here
        self.searchController = self.addSearchController(tintColor: UIColor.white, textColor: UIColor.white, placeHolderText: "Type country name here...")
//        self.interactor?.searchCountries(name: "India")

        
        self.countriesTableView.rowHeight = UITableView.automaticDimension
        self.countriesTableView.estimatedRowHeight = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ? 80 : 60
    }
}

// MARK: - UITableView Delegate and Datasource
extension CountriesSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.countries != nil && (self.countries?.count)! > 0{
            return (self.countries?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let countryCell = tableView.dequeueReusableCell(withIdentifier: "countriesCellIdentifier") as! CountriesTableViewCell
        countryCell.setUpCountryCell(country: self.countries![indexPath.row])
        return countryCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let countryDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.countryDetailViewControllerIdentifier) as! CountryDetailsViewController
        countryDetailsViewController.countryInformation = self.countries?[indexPath.row]
        self.navigationController?.pushViewController(countryDetailsViewController, animated: true)
    }
}

extension CountriesSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if (text.count > 0) {
            self.interactor?.searchCountries(name: text)
        }
        else {
            self.countryListAPIFailed()
        }
    }
}

extension CountriesSearchViewController: CountriesViewDisplayable {
    
    func moveToCountryDetails() {
        
    }
    
    func refreshCountryList(countries: Countries) {
        
        self.countries = countries
        
        if (self.countries != nil) {
            self.countriesCountLabel.text = self.countries?.count == 1 ? String.init(format: Constants.differentCountry, (self.countries?.count)!) : String.init(format: Constants.differentCountries, (self.countries?.count)!)
        }
        
        if self.countries != nil && (self.countries?.count)! > 0 {
            self.noRecordsFoundLabel.isHidden = true
        }
        else if (self.countries?.count == 0 || self.countries == nil)  {
            self.noRecordsFoundLabel.isHidden = false
            self.countriesCountLabel.text = String.init(format: Constants.differentCountries, 0)
            
        }
        self.countriesTableView.reloadData()
    }
    
    func countryListAPIFailed() {
        self.countries = nil
        self.noRecordsFoundLabel.isHidden = false
        self.countriesCountLabel.text = String.init(format: Constants.differentCountries, 0)
        self.countriesTableView.reloadData()
    }
}
