//
//  CurrentCitiesViewController.swift
//  WeatherApp
//
//  Created by Art on 23.07.2021.
//

import UIKit

class CurrentCitiesViewController: UIViewController {
    //MARK: - Outlets
    //таблица с городами
    @IBOutlet var citiesTableView: UITableView!
    //MARK: - Properties
    //идентификатор для ячейки
    private let cellID = "CityTableViewCell" //вызываем идентификатор
    
    //массив с городами
    var cities = [City(name: "Moscow", image: nil),
                  City(name: "Tokyo", image: nil),
                  City(name: "Paris", image: UIImage(named: "22")),
                  City(name: "London", image: nil),
                  City(name: "Sochi", image: UIImage(named: "11"))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(colorWasChanged(_:)), name: NSNotification.Name.ColorChanged, object: nil)
    }
    
    @objc private func colorWasChanged(_ notification: Notification) {
        guard let color = notification.userInfo? ["color"] as? UIColor else {return}
        view.backgroundColor = color
    }
     
    //добавляем сегу возвращения и добавления выбранного города
    @IBAction private func goBackFromAvaliableScreen(with segue: UIStoryboardSegue) {
        //выбираем контроллер куда переходим destination - куда мы выйдем, source - от куда мы выходим(текущий контроллер), получаем текущий выделенный элемент из таблицы
        guard let avaliableVC = segue.source as? AvaliableCityViewController,
              let indexPath = avaliableVC.avalibleTableView.indexPathForSelectedRow else {return}
        //  получаем новый город
        let newCity = avaliableVC.cities[indexPath.row] // извлекаем текущий выбранный город

        //проверием на добавление уже добавленных городов
        guard !cities.contains(where: { city -> Bool in         //guard cities.contains(where: {$0.name == newCity.name})
                                city.name == newCity.name })
        else {return}
        cities.append(newCity) // добавляем новый город в массив
        citiesTableView.reloadData() //перезапускаем вьюху таблицы
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let forecastVC = segue.destination as? ForecastViewController,
              let indexPath = citiesTableView.indexPathForSelectedRow else {return}
        forecastVC.currentCity = cities[indexPath.row].name
    }
}

//вызываем методы для отображения информации в таблице не забыть выставить оутлеты от таблицы к контроллеру
extension CurrentCitiesViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //количество строк в секции
        return cities.count
    }
    
    //метод, позволяющий переиспользовать ячейку, indexPath - нумерация ячеек
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //создаем ячейку, идентификатор ячейки из сториборда и индекс нумерации, кастим к типу ячейки и убираем опциональность
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? CityTableViewCell else {
            fatalError("{Message: Error in dequeue CityTableViewCell}")
        }
        //после добавления оутлетов в CityTableViewCell появляется доступ к ним
        cell.cityImage.image = cities[indexPath.row].image //обращаемся к массиву, row - текущий элемент
        cell.cityName.text = cities[indexPath.row].name
        return cell
    }
}

extension CurrentCitiesViewController: UITableViewDelegate {
    //удаление элементов таблицы
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            return
        }
    }
}
