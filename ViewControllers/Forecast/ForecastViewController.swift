//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Art on 23.07.2021.
//

import UIKit

class ForecastViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var dailyControl: DailyControl!
    
    //MARK: - Properties

    var currentCity = ""
    private var forecastItems: [Weather]?
    
    //MARK: - Сервисы
    private let networkService: NetworkService = NetworkServiceImplementation()

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "ForecastCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: ForecastCollectionViewCell.reuseID)
        fetchWeatherForecast()
    }
    
    //MARK: - Functions
    //индикатор и загрузка данных
    private func fetchWeatherForecast() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        view.addSubview(activityIndicator)
        activityIndicator.frame = CGRect(x: view.center.x, y: view.frame.midY + 20, width: 45, height: 45)
        activityIndicator.startAnimating()
        networkService.getCurrentWeatherForecast(city: currentCity) {[weak self] weathers in
            guard let self = self else { return }
            self.forecastItems = weathers
            self.collectionView.reloadData()
            activityIndicator.stopAnimating()
        }
    }
}

//MARK: - Extension CollectionView Func

extension ForecastViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        forecastItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCollectionViewCell.reuseID, for: indexPath) as? ForecastCollectionViewCell,
              let forecastItems = forecastItems else { return UICollectionViewCell() }
        cell.configure(with: forecastItems[indexPath.row])
        return cell
    }
}
