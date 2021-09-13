//
//  AvaliableCityViewController.swift
//  WeatherApp
//
//  Created by Art on 23.07.2021.
//

import UIKit

class AvaliableCityViewController: UIViewController {
//MARK: - Outlets
    @IBOutlet var avalibleTableView: UITableView!
    //MARK: - Properties
    private var avaliableID = "AvaliableCitiesTableViewCell"
    
    var cities = [City(name: "NewYork", image: nil),
                  City(name: "Kaliningrad", image: UIImage(named: "44")),
                  City(name: "Belgorod", image: UIImage(named: "11")),
                  City(name: "Minsk", image: UIImage(named: "22")),
                  City(name: "Saratov", image: UIImage(named: "33"))]
    
    var firstCharacters = [Character] ()
    var sortedCities: [Character : [City]] = [:]
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        (firstCharacters, sortedCities) = sort(cities)
    }
    
    //MARK: - Function
    ///регистрируем созданный файл с прототипом ячейки
    private func setupTableView() {
        let cellNib = UINib(nibName: avaliableID, bundle: nil)
        avalibleTableView.register(cellNib, forCellReuseIdentifier: avaliableID)
    }
    
    func sort(_ cities: [City]) -> (characters: [Character], sortedCities: [Character : [City]]) {
        var characters = [Character]()
        var sortedCities = [Character : [City]]()
        
        cities.forEach { city in
            guard let character = city.name.first else {return}
            if var thisCharCities = sortedCities[character] {
                thisCharCities.append(city)
                sortedCities[character] = thisCharCities
            } else {
                sortedCities[character] = [city]
                characters.append(character)
            }
        }
        characters.sort()
        return (characters, sortedCities)
    }
}

extension AvaliableCityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        firstCharacters.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let character = firstCharacters[section]
        let citiesCount = sortedCities[character]?.count
        return citiesCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: avaliableID, for: indexPath) as? AvaliableCitiesTableViewCell else {
            fatalError("{Message: Error in dequeue \(avaliableID)}")
        }
        ///передаем данные из ячейки, сделанной отдельным файлом
        let character = firstCharacters[indexPath.section]
        guard let cities = sortedCities[character] else {return UITableViewCell()}
        cell.configure(with: cities[indexPath.row])
        //говорим что делегатом будет этот контроллер
        cell.delegate = self
        ///передаем данные из ячейки сделаной в сториборде
//        cell.cityImageView.image = cities[indexPath.row].image
//        cell.cityNameLabel.text = cities[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(firstCharacters[section])
    }
}

//добавляем делегат к контроллеру
extension AvaliableCityViewController: AvaliableCitiesTableViewCellDelegate {
    //функция которая делегированна этому контроллеру
    func postColorNotification(with color: UIColor) {
               //отправляем уведомление в центр
        NotificationCenter.default.post(name: NSNotification.Name.ColorChanged, object: nil, userInfo: ["color" : color])
    }
}
