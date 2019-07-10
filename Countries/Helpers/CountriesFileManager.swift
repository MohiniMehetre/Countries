//
//  CountriesFileManager.swift
//  Countries
//
//  Created by Mohini Mehetre on 29/06/19.
//  Copyright © 2019 Mohini Mehetre. All rights reserved.
// I changed this line to cross check with Jenkins

import UIKit

class CountriesFileManager: NSObject {
    
    /// Creates shared instance for countries file manager.
    private static var sharedInstance: CountriesFileManager  =  {
        let countriesFileManager = CountriesFileManager()
        return countriesFileManager
    }()
    
    // This prevents others from using the default '()' initializer for this class.
    override private init() {
        super.init()
    }
    
    /// Returns shared instance for countries file manager.
    class func shared() -> CountriesFileManager {
        return sharedInstance
    }
    
    /// Saves an image with given name into app's documents folder.
    /// - Parameter fileName: Name of image file in documents folder.
    /// - Parameter image: Image to be saved.
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
    
    /// Returns an image with given name from app's documents folder.
    /// - Parameter fileName: Name of image file in documents folder.
    /// - Returns: Image with given name from documents folder.
    func getImageFromFileNamed(fileName: String) -> UIImage? {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = documentsURL.appendingPathComponent("\(fileName).png").path
        if FileManager.default.fileExists(atPath: filePath) {
            return UIImage(contentsOfFile: filePath)!
        }
        return nil
    }
}
