//
//  CurrentLocationViewController.swift
//  WeatherApp
//
//  Created by Art on 30.12.2021.
//

import UIKit
import CoreLocation

class CurrentLocationViewController: UIViewController {
    
//MARK: - Properties
    private var weathers: [Weather]?
    private var city: LocalCityModel?
    
    private let network: NetworkingOperation = WeatherOperationQueue()
    private let locationManager = CLLocationManager()
    
//MARK: - UI elements
    private var tableView: UITableView!
    
//MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setLocationManager()
    }
    
//MARK: - Methods
    private func setTableView() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(CurrentLocationHeader.self, forHeaderFooterViewReuseIdentifier: CurrentLocationHeader.reuseId)
        tableView.register(CurrentLocationTableCell.self, forCellReuseIdentifier: CurrentLocationTableCell.reuseId)
        view.addSubview(tableView)
    }
    
    private func setLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func fetchData(coord: CLLocationCoordinate2D) {
        let lat = Int(coord.latitude)
        let lon = Int(coord.longitude)
        
        network.getLocalWeather(lat: lat, lon: lon) {[weak self] weathers, city in
            guard let self = self else { return }
            self.weathers = weathers
            self.city = city
            self.tableView.reloadData()
        }
    }
}

//MARK: - TableView
extension CurrentLocationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: CurrentLocationHeader.reuseId) as? CurrentLocationHeader else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentLocationTableCell.reuseId, for: indexPath) as? CurrentLocationTableCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

//MARK: - LocationDelegate
extension CurrentLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        if let coord = locations.last?.coordinate {
            fetchData(coord: coord)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showError(error.localizedDescription)
    }
}
