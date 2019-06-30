//
//  CountriesTableViewCell.swift
//  Countries
//
//  Created by Mohini Mehetre on 29/06/19.
//  Copyright © 2019 Mohini Mehetre. All rights reserved.
//

import UIKit

class CountriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    /// Sets values to the UITableViewCell for country list
    /// - Parameter country: CountryInformation object that contains all information about the specific country.
    func setUpCountryCell(country: CountryInformation) {
        
        //Set country name
        self.nameLabel.text = country.name ?? ""
        
        //Load and set flag image asynchronously
        let fileName = NSURL(fileURLWithPath: (country.flag)!).deletingPathExtension?.lastPathComponent
        let flagImage = CountriesFileManager.shared().getImageFromFileNamed(fileName: fileName!)
        
        if(flagImage != nil) {
            self.flagImageView.image = flagImage
        }
        else {
            self.flagImageView.downloadAndSetImageWithUrl(imageUrl: country.flag ?? "")
        }
    }
}
