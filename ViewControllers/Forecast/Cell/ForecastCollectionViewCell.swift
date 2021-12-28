//
//  ForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Art on 02.08.2021.
//

import UIKit
import Kingfisher

class ForecastCollectionViewCell: UICollectionViewCell {
    static let reuseID = "ForecastCollectionViewCell"
    //MARK: - Outlets
    
    @IBOutlet var forecastImageView: UIImageView!
    @IBOutlet var counterLikeLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    //MARK: - Properties
    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "EEEE, HH:mm"
        return df
    }()
    
    //MARK: - Functions
    
    func configure(with weather: Weather) {
        counterLikeLabel.text = String(weather.pressure)
        temperatureLabel.text = String(format: "%.0f℃", weather.temperature)
        
        guard let url = URL(string: "https://api.openweathermap.org/img/w/\(weather.icon).png") else { return }
        forecastImageView.kf.setImage(with: url)
         
    }
}
