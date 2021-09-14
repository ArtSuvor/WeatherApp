//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Art on 23.07.2021.
//

import UIKit
import RealmSwift

class ForecastViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var dailyControl: DailyControl!
    
    
    private let resuseID = "ForecastCollectionViewCell"
    var currentCity = ""

    
    //MARK: - Сервисы
    private let networkService: NetworkService = NetworkServiceImplementation()
    private var forecastItems = [RealmWeather]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "ForecastCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: resuseID)
        networkService.getCurrentWeatherForecast(city: currentCity) { [weak self] in
            self?.loadData()
            self?.collectionView.reloadData()
        }
    }
    
    private func loadData() {
        do {
            let realm = try Realm()
            let forecastWeather = realm.objects(RealmWeather.self).filter("city == %@", currentCity)
            self.forecastItems = Array(forecastWeather)
        } catch let error {
            print(error)
        }
    }
}


extension ForecastViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resuseID, for: indexPath) as? ForecastCollectionViewCell else {
            fatalError("{Message: Error in dequeue CityTableViewCell}")
        }
//        cell.delegate = self
        cell.configure(with: forecastItems[indexPath.row], indexPath: indexPath)
        return cell
    }
}

//extension ForecastViewController: ForecastCollectionViewCellDelegate {
//    func heartWasPressed(indexPath: IndexPath) {
//        forecastItems[indexPath.row].isLike.toggle()
//        forecastItems[indexPath.row].likeCount += forecastItems[indexPath.row].isLike ? 1 : -1
//        collectionView.reloadItems(at: [indexPath])
//    }
//}
