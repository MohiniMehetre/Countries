//
//  AppDisplayable.swift
//  Countries
//
//  Created by Mohini Mehetre on 29/06/19.
//  Copyright © 2019 Mohini Mehetre. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import Alamofire

protocol AppDisplayable {
    /// Returns internet connectivity.
    /// - Returns: Bool value for connectivity. True when online and False when Offline.
    func isConnectedToInternet() -> Bool
    
    /// Shows activity indiator with given message.
    /// - Parameter message: Message that needs to be shown on activity indicator.
    func showActivity(with message: String?)
    
    /// Hides currently shown activity indiator.
    func hideActivity()
    
    /// Shows alert message on current view controller.
    /// - Parameter title: Title for alert.
    /// - Parameter message: Message that needs to be shown on alert.
    func showAlert(title: String, message: String)
}

extension AppDisplayable where Self: UIViewController {
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    func showActivity(with message: String?) {
        self.showHUD(progressLabel: message!)
    }
    
    func hideActivity() {
        self.dismissHUD(isAnimated: true)
    }
    
    func showAlert(title: String, message: String){
        self.showMessage(title: title, message: message)
    }
}
