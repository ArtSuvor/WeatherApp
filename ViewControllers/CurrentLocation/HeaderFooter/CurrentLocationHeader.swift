//
//  CurrentLocationHeader.swift
//  WeatherApp
//
//  Created by Art on 30.12.2021.
//

import UIKit

class CurrentLocationHeader: UITableViewHeaderFooterView {
    static let reuseId = "CurrentLocationHeader"
    
//MARK: - UI elements
    private let nameCityLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let backImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//MARK: - Methods
    func configure(modelWeather: Weather, modelCity: LocalCityModel) {
        nameCityLabel.text = modelCity.name
        temperatureLabel.text = String(format: "%.0f℃", modelWeather.temperature)
        descriptionLabel.text = modelWeather.textDiscription
    }
    
    private func setViews() {
        addSubview(backImageView)
        backImageView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        backImageView.layer.cornerRadius = 20
        backImageView.layer.masksToBounds = true
        backImageView.addSubview(nameCityLabel)
        backImageView.addSubview(temperatureLabel)
        backImageView.addSubview(descriptionLabel)
    }
}

//MARK: - Constraints
extension CurrentLocationHeader {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backImageView.topAnchor.constraint(equalTo: topAnchor),
            backImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backImageView.bottomAnchor.constraint(equalTo: bottomAnchor)])
        
        NSLayoutConstraint.activate([
            nameCityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameCityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameCityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: nameCityLabel.bottomAnchor, constant: 5),
            temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)])
    }
}
