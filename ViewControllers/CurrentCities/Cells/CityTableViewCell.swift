//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Art on 23.07.2021.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet private var cityName: UILabel!
    @IBOutlet private var cityImage: CustomImageView!
    
    func configure(weather: FirebaseCity) {
        cityName.text = weather.name
        cityImage.image = UIImage(named: "11")
    }
}
