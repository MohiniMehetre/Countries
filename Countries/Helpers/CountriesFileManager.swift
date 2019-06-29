//
//  CountriesFileManager.swift
//  Countries
//
//  Created by Mohini Mehetre on 29/06/19.
//  Copyright © 2019 Mohini Mehetre. All rights reserved.
//

import UIKit

class CountriesFileManager: NSObject {
    
    private static var sharedInstance: CountriesFileManager  =  {
        let countriesFileManager = CountriesFileManager()
        return countriesFileManager
    }()
    
    // This prevents others from using the default '()' initializer for this class.
    override private init() {
        super.init()
    }
    
    // MARK:- Accessor -
    class func shared() -> CountriesFileManager {
        return sharedInstance
    }
    
    func saveFileNamed(fileName: String, image: UIImage) -> String? {
        do {
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsURL.appendingPathComponent("\(fileName).png")
            
            //First delete existing file if already exists
            if FileManager.default.fileExists(atPath: fileURL.absoluteString) {
                try FileManager.default.removeItem(at: fileURL)
            }
            
            //Save file locally
            if let pngImageData = image.pngData() {
                try pngImageData.write(to: fileURL, options: .atomic)
            }
            return fileURL.absoluteString
        } catch {
            print("Error")
        }
        return nil
    }
    
    func getImageFromFileNamed(fileName: String) -> UIImage? {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = documentsURL.appendingPathComponent("\(fileName).png").path
        if FileManager.default.fileExists(atPath: filePath) {
            return UIImage(contentsOfFile: filePath)!
        }
        return nil
    }
}
