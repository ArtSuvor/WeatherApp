//
//  CurrentCitiesViewController.swift
//  WeatherApp
//
//  Created by Art on 23.07.2021.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CurrentCitiesViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet var citiesTableView: UITableView!
    
    //MARK: - Properties
    private let cellID = "CityTableViewCell"
    private let databaseServise: DatabaseService = DatabaseServiceImpl()
    private var cities = [FirebaseCity]()
    private let ref = Database.database(url: "https://gbweather-b0c7e-default-rtdb.firebaseio.com/").reference(withPath: "cities")
 
//MARK: - Life cycle
    
    override func viewDidLoad() {
        setupRefObserve()
    }
    
//MARK: - Functions
    
    private func setupRefObserve() {
        ref.observe(.value) {[weak self] snapshot in
            guard let self = self else { return }
            var cities: [FirebaseCity] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                   let city = FirebaseCity(snapshot: snapshot) {
                    cities.append(city)
                }
            }
            self.cities = cities
            self.citiesTableView.reloadData()
        }
    }
    
//    передача текущего города в другой vc
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let forecastVC = segue.destination as? ForecastViewController,
              let indexPath = citiesTableView.indexPathForSelectedRow else {return}
        forecastVC.currentCity = cities[indexPath.row].name
    }

    
//MARK: - FuncAction
    
    @IBAction func addCityAction(_ sender: Any) {
        let alertVC = UIAlertController(title: "Введите название города", message: nil, preferredStyle: .alert)
        alertVC.addTextField()
        let okButton = UIAlertAction(title: "Ok", style: .default) {[weak self] _ in
            guard let cityName = alertVC.textFields?.first?.text, !cityName.isEmpty else { return }
            let city = FirebaseCity(name: cityName, zipcode: Int.random(in: 100000...999999))
            let cityRef = self?.ref.child(cityName.lowercased())
            cityRef?.setValue(city.toAnyObject())
        }
        let cancelButton = UIAlertAction(title: "Отмена", style: .cancel)
        alertVC.addAction(okButton)
        alertVC.addAction(cancelButton)
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch let error {
            showAlertError(title: "Ошибка", message: error.localizedDescription)
        }
    }
}

//MARK: - Extension Table Properties

//вызываем методы для отображения информации в таблице не забыть выставить оутлеты от таблицы к контроллеру
extension CurrentCitiesViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //количество строк в секции
        cities.count
    }
    
    //метод, позволяющий переиспользовать ячейку, indexPath - нумерация ячеек
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? CityTableViewCell
        else { return UITableViewCell() }
        cell.configure(weather: cities[indexPath.row])
        return cell
    }
}

//MARK: - Extension Удаление ячеек

extension CurrentCitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let city = cities[indexPath.row]
            city.ref?.removeValue()
        default:
            return
        }
    }
}
