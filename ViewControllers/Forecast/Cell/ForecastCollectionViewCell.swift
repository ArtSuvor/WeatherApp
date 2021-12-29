//
//  ForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Art on 02.08.2021.
//

import UIKit
import Kingfisher

final class ForecastCollectionViewCell: UICollectionViewCell {
    static let reuseID = "ForecastCollectionViewCell"
//MARK: - UI elements
    private let iconImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pressureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Functions
    private func setViews() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 5
        layer.masksToBounds = true
        addSubview(iconImageView)
        addSubview(temperatureLabel)
        addSubview(pressureLabel)
        addSubview(dateLabel)
        addSubview(descriptionLabel)
    }
    
    func configure(with weather: Weather) {
        pressureLabel.text = String(format: "%.0fMm", weather.pressure)
        temperatureLabel.text = String(format: "%.0f℃", weather.temperature)
        descriptionLabel.text = weather.textDiscription
        dateLabel.text = DateFormatterDate.shared.getDateString(date: weather.date)
        
        guard let url = URL(string: "https://api.openweathermap.org/img/w/\(weather.icon).png") else { return }
        iconImageView.kf.setImage(with: url)
         
    }
}

//MARK: - Constraints
extension ForecastCollectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)])
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            iconImageView.heightAnchor.constraint(equalToConstant: 50)])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)])
        
        NSLayoutConstraint.activate([
            pressureLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 5),
            pressureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            pressureLabel.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -10)])
    }
}
