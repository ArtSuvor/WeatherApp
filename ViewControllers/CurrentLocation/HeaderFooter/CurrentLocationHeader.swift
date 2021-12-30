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
        label.text = "sfsfisf"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "skfghjk"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 70)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "skjhfgusui"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    func configure() {
        
    }
    
    private func setViews() {
        backgroundColor = .secondarySystemBackground
        addSubview(nameCityLabel)
        addSubview(temperatureLabel)
        addSubview(descriptionLabel)
    }
}

//MARK: - Constraints
extension CurrentLocationHeader {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameCityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            nameCityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameCityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: nameCityLabel.bottomAnchor, constant: 10),
            temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20)])
    }
}
