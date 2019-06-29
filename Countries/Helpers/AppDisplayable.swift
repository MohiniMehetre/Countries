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
    func isConnectedToInternet() -> Bool
    func showActivity(with message: String?)
    func hideActivity()
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
