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

    func setUpCountryCell(country: CountryInformation) {
        
        //Set country name
        self.nameLabel.text = country.name ?? ""
        
        //Load and set flag image asynchronously
        self.flagImageView.setImageWithUrl(imageUrl: country.flag ?? "")
    }
}
