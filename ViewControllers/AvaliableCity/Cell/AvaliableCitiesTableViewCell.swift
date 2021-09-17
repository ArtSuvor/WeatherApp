//
//  AvaliableCitiesTableViewCell.swift
//  WeatherApp
//
//  Created by Art on 26.07.2021.
//

//import UIKit
//
////создаем делегат
//protocol AvaliableCitiesTableViewCellDelegate: AnyObject {
//    func postColorNotification(with color: UIColor)
//}
//
//class AvaliableCitiesTableViewCell: UITableViewCell {
//
////MARK: - Outlets
//    ///Название города
//    @IBOutlet private var cityNameLabel: UILabel!
//    ///Картинка города
//    @IBOutlet private var cityImageView: UIImageView!
//
//    //MARK: - Properties
//    weak var delegate: AvaliableCitiesTableViewCellDelegate?
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        addGestureRecognizer()
//    }
//
//    //MARK: - Methods
//    func configure(with city: City) {
//        cityNameLabel.text = city.name
//        cityImageView.image = city.image
//    }
//
//    private func addGestureRecognizer() {
//        let tapGR = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
//        cityImageView.addGestureRecognizer(tapGR)
//    }
//
//    //функция действия при нажатии
//    @objc private func tapHandler() {
//        delegate?.postColorNotification(with: UIColor.green)
//    }
//}
