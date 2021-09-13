//
//  ForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Art on 02.08.2021.
//

import UIKit
import Kingfisher

protocol ForecastCollectionViewCellDelegate: AnyObject {
    func heartWasPressed(indexPath: IndexPath)
}

class ForecastCollectionViewCell: UICollectionViewCell {

    //MARK: - Outlets
    
    @IBOutlet var forecastImageView: UIImageView!
    @IBOutlet var heartImageView: UIImageView!
    @IBOutlet var counterLikeLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    //MARK: - Properties
    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "EEEE, HH:mm"
        return df
    }()
    
    weak var delegate: ForecastCollectionViewCellDelegate?
    var selectedIndexPath: IndexPath?
    
    //MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(heartTap))
        heartImageView.addGestureRecognizer(tapGR)
    }
    
    //MARK: - Functions
    
    @objc private func heartTap() {
       
        guard let indexPath = selectedIndexPath else {return}
        delegate?.heartWasPressed(indexPath: indexPath)
    }
    
    func configure(with weather: Weather, indexPath: IndexPath) {
        selectedIndexPath = indexPath
        
        counterLikeLabel.text = String(weather.likeCount)
        temperatureLabel.text = String(format: "%.0f℃", weather.temperature)
        heartImageView.image = weather.isLike ? CellConsts.fillImage : CellConsts.emptyImage

        
        let prettyDate = dateFormatter.string(from: weather.date)
        let url = URL(string: "https://api.openweathermap.org/img/w/\(weather.icon).png")
        forecastImageView.kf.setImage(with: url!)
         
    }
    
    //MARK: - Structs
    
    private struct CellConsts {
        static let fillImage = UIImage(systemName: "heart.fill")
        static let emptyImage = UIImage(systemName: "heart")
    }
}
