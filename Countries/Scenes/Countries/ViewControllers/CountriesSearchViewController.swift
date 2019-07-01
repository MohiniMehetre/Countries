//
//  CountriesSearchViewController.swift
//  Countries
//
//  Created by Mohini Mehetre on 29/06/19.
//  Copyright © 2019 Mohini Mehetre. All rights reserved.
//

import UIKit
import Alamofire

class CountriesSearchViewController: UIViewController {
    
    lazy var interactor :CountryBusinessLogic? = CountryInteractor(viewControllerRef: self)
    
    @IBOutlet weak var countriesTableView: UITableView!
    @IBOutlet weak var countriesCountLabel: UILabel!
    @IBOutlet weak var noRecordsFoundLabel: UILabel!
    
    var countries: Countries?
    var searchedCountries: Countries?
    var isSearching = false
    var searchController: UISearchController? = nil
    let reachabilityManager = NetworkReachabilityManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initializeView()
    }
    
    // MARK:- Private Methods -
    
    /// This method sets up the initial values for view when loaded.
    func initializeView() {
        
        //UI related stuff here
        self.searchController = self.addSearchController(tintColor: UIColor.white, textColor: UIColor.white, placeHolderText: "Type country name here...")
        
        self.countriesTableView.rowHeight = UITableView.automaticDimension
        self.countriesTableView.estimatedRowHeight = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ? 80 : 60
        
        self.listenToNetworkUpdates()
    }
    
    /// This methods updates the label on current view based on country values and reloads table.
    func refreshTableView () {
        
        if (self.searchedCountries != nil) {
            self.countriesCountLabel.text = self.searchedCountries?.count == 1 ? String.init(format: Constants.differentCountry, (self.searchedCountries?.count)!) : String.init(format: Constants.differentCountries, (self.searchedCountries?.count)!)
        }
        
        if self.searchedCountries != nil && (self.searchedCountries?.count)! > 0 {
            self.noRecordsFoundLabel.isHidden = true
            self.countriesTableView.reloadData()
        }
        else if (self.searchedCountries?.count == 0 || self.searchedCountries == nil)  {
            self.clearCountryList()
        }
    }
}

// MARK: - UITableView Delegate and Datasource -
extension CountriesSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchedCountries != nil && (self.searchedCountries?.count)! > 0{
            return (self.searchedCountries?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier = "countriesCellIdentifier_webView" //With WKWebView
        let country = self.searchedCountries![indexPath.row]
        let fileName = NSURL(fileURLWithPath: (country.flag)!).deletingPathExtension?.lastPathComponent
        let flagImage = CountriesFileManager.shared().getImageFromFileNamed(fileName: fileName!)
        
        if(flagImage != nil) {
            cellIdentifier = "countriesCellIdentifier" //With UIImageView
        }
        
        let countryCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CountriesTableViewCell
        
        countryCell.setUpCountryCell(country: country)
        return countryCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let countryDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.countryDetailViewControllerIdentifier) as! CountryDetailsViewController
        countryDetailsViewController.countryInformation = self.searchedCountries?[indexPath.row]
        self.navigationController?.pushViewController(countryDetailsViewController, animated: true)
    }
}

// MARK: - UISearchResultsUpdating  -
extension CountriesSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.handleSearchBarTextChange(searchText: searchController.searchBar.text)
    }
}

// MARK: - CountriesViewDisplayable  -
extension CountriesSearchViewController: CountriesViewDisplayable {
    
    func handleSearchBarTextChange(searchText: String?) {
        guard let text = searchText else { return }
        if (text.count > 0) {
            self.isSearching = true
            //Use this when search has to happen through API
            //  self.interactor?.searchCountries(name: text)
            
            //search from local array
            if (self.countries != nil) {
                self.searchedCountries = self.interactor?.searchCountry(name: text, from: self.countries!)
                self.refreshTableView()
            }
        }
        else {
            self.isSearching = false
            self.clearCountryList()
        }
    }
    
    func listenToNetworkUpdates() {
        reachabilityManager?.startListening()
        reachabilityManager?.listener = { _ in
            self.countries?.removeAll()
            self.searchedCountries?.removeAll()
            self.interactor?.checkConnectivityAndLoadEntries()
        }
    }
    
    
    func searchCountryAPIFailed() {
        self.clearCountryList()
    }
    
    func clearCountryList() {
        
        //show locally saved countries when offline
        if (!self.isConnectedToInternet() && !self.isSearching) {
            if (self.countries != nil && (self.countries?.count)! > 0) {
                self.searchedCountries = self.countries
                self.refreshTableView()
                return
            }
        }
        
        self.searchedCountries?.removeAll()
        self.noRecordsFoundLabel.isHidden = false
        if (self.searchController?.searchBar.text?.isEmpty)! {
            self.noRecordsFoundLabel.text = Constants.typeToSearchCountryMessage
        }
        else {
            self.noRecordsFoundLabel.text = Constants.noResultsFoundMessage
        }
        self.countriesCountLabel.text = String.init(format: Constants.differentCountries, 0)
        self.countriesTableView.reloadData()
    }
    
    func refreshCountryList(countries: Countries) {
        self.countries = countries
        self.refreshTableView()
        if (self.isSearching) {
            self.handleSearchBarTextChange(searchText: self.searchController?.searchBar.text)
        }
    }
    
    func countryListAPIFailed() {
        self.clearCountryList()
    }
}
