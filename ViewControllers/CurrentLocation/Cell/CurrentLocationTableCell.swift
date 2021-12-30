//
//  CurrentLocationTableCell.swift
//  WeatherApp
//
//  Created by Art on 30.12.2021.
//

import UIKit

class CurrentLocationTableCell: UITableViewCell {
    static let reuseId = "CurrentLocationTableCell"
    
//MARK: - UI elements
    private let iconImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pressureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        addSubview(iconImageView)
        addSubview(dateLabel)
        addSubview(temperatureLabel)
        addSubview(pressureLabel)
    }
}

//MARK: - Constraints
extension CurrentLocationTableCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)])
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)])
        
        NSLayoutConstraint.activate([
            pressureLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            pressureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            pressureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            pressureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)])
    }
}
