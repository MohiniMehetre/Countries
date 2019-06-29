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

protocol AppDisplayable {
    
    func showActivity(with message: String?)
    func hideActivity()
    func showAlert(title: String, message: String)
}

extension AppDisplayable where Self: UIViewController {
        
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
