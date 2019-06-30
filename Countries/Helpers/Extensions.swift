//
//  Extensions.swift
//  Countries
//
//  Created by Mohini Mehetre on 29/06/19.
//  Copyright © 2019 Mohini Mehetre. All rights reserved.
//

import UIKit
import MBProgressHUD
import SVGKit

extension UIViewController {
    
    /// Adds searchcontroller for current viewcontroller.
    /// - Parameter tintColor: Tint color for searchbar.
    /// - Parameter textColor: Text color for searchbar.
    /// - Parameter placeHolderText: Place holder to be shown when there is no text in searchbar
    /// - Returns: Created instance of UISearchController.
    func addSearchController(tintColor: UIColor?, textColor: UIColor?, placeHolderText: String?) -> UISearchController{
        
        //Search controller
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self as? UISearchResultsUpdating
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = placeHolderText ?? search.searchBar.placeholder
        search.searchBar.tintColor = tintColor ?? search.searchBar.tintColor
        navigationItem.searchController = search
        definesPresentationContext = true

        // SearchBar text
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: textColor ?? UIColor.black]
        
        return search
    }
    
    /// Shows alert message on current view controller.
    /// - Parameter title: Title for alert.
    /// - Parameter message: Message that needs to be shown on alert.
    func showMessage(title: String, message : String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let OKAction = UIAlertAction(title: "OK", style: .cancel) {
            (action: UIAlertAction) in
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
  
    /// Shows activity indiator with given message.
    /// - Parameter progressLabel: Message that needs to be shown on activity indicator.
    func showHUD(progressLabel:String){
        let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHUD.label.text = progressLabel
    }
    
    /// Hides currently shown activity indiator.
    func dismissHUD(isAnimated:Bool) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: isAnimated)
        }
    }
}

extension UIImageView {
    
    /// Download the image from server url and sets it to current imageview.
    /// - Parameter imageUrl: Image url coming from server.
    func downloadAndSetImageWithUrl(imageUrl: String) {
        URLSession.shared.dataTask(with: NSURL(string: imageUrl)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let anSVGImage: SVGKImage = SVGKImage(data: data)
                self.image = anSVGImage.uiImage
            })
        }).resume()
    }
}
