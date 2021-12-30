//
//  CurrentLocationTableCell.swift
//  WeatherApp
//
//  Created by Art on 30.12.2021.
//

import UIKit
import Kingfisher

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
        label.text = "agfaer"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "aghjafaer"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pressureLabel: UILabel = {
        let label = UILabel()
        label.text = "aghjadhfaer"
        label.font = UIFont.systemFont(ofSize: 20)
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
    func configure(model: Weather) {
        dateLabel.text = DateFormatterDate.shared.getDateString(date: model.date)
        pressureLabel.text = String(format: "%.0fMm", model.pressure)
        temperatureLabel.text = String(format: "%.0f℃", model.temperature)
        
        guard let url = URL(string: "https://api.openweathermap.org/img/w/\(model.icon).png") else { return }
        iconImageView.kf.setImage(with: url)
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
            iconImageView.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 5),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30)])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            temperatureLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 5),
            temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)])
        
        NSLayoutConstraint.activate([
            pressureLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            pressureLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 5),
            pressureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            pressureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)])
    }
}
