//
//  CustomImageView.swift
//  WeatherApp
//
//  Created by Art on 29.12.2021.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }
}
