//
//  AvaliableCitiesViewController.swift
//  WeatherApp
//
//  Created by Art on 22.07.2021.
//

import UIKit

class AvaliableCitiesViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private let avaliableID = "AvaliableCityID"
    
    var cities = [City(name: "London", image: nil),
                  City(name: "Paris", image: UIImage(named: "22")),
                  City(name: "NewYork", image: UIImage(named: "44"))]
}

extension AvaliableCitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: avaliableID, for: indexPath) as? CityTableViewCell else {
            fatalError("{ Message: Error in dequeue CityTableViewCell }")
        }
        cell.cityImage.image = cities[indexPath.row].image
        cell.cityName.text = cities[indexPath.row].name
        return cell
    }
}

extension AvaliableCitiesViewController: UITableViewDelegate {
    
}
