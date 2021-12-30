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
    private var coords: CLLocationCoordinate2D?
    
    private let refControl = UIRefreshControl()
    private let network: NetworkingOperation = WeatherOperationQueue()
    private let locationManager = CLLocationManager()
    
//MARK: - UI elements
    private var tableView: UITableView!
    
//MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setLocationManager()
        setRefControl()
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
    
    @objc private func fetchData() {
        guard let lat = coords?.latitude,
              let lon = coords?.longitude else { return }
        
        network.getLocalWeather(lat: Int(lat), lon: Int(lon)) {[weak self] weathers, city in
            guard let self = self else { return }
            self.weathers = weathers
            self.city = city
            self.tableView.reloadData()
            self.locationManager.stopUpdatingLocation()
            self.refControl.endRefreshing()
        }
    }
    
    private func setRefControl() {
        refControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        tableView.refreshControl = refControl
    }
}

//MARK: - TableView
extension CurrentLocationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: CurrentLocationHeader.reuseId) as? CurrentLocationHeader else { return UITableViewCell() }
        if let weather = weathers?[section], let city = city {
            cell.configure(modelWeather: weather, modelCity: city)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weathers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentLocationTableCell.reuseId, for: indexPath) as? CurrentLocationTableCell else { return UITableViewCell() }
        if let weather = weathers?[indexPath.row] {
            cell.configure(model: weather)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

//MARK: - LocationDelegate
extension CurrentLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.coords = locations.last?.coordinate
        fetchData()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showError(error.localizedDescription)
    }
}
