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
    
    //MARK: - Properties
    private let resuseID = "ForecastCollectionViewCell"
    var currentCity = ""
    
    //MARK: - Сервисы
    private let networkService: NetworkService = NetworkServiceImplementation()
    private let databaseService: DatabaseService = DatabaseServiceImpl()
    private var forecastItems = try? Realm().objects(RealmWeather.self)
    private var notificationToken: NotificationToken?

    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "ForecastCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: resuseID)
        fetchWeatherForecast()
        setupNotificationToken()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationToken?.invalidate()
    }
    
    //MARK: - Functions
    //индикатор и загрузка данных
    private func fetchWeatherForecast() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        view.addSubview(activityIndicator)
        activityIndicator.frame = CGRect(x: view.center.x, y: view.frame.midY + 20, width: 45, height: 45)
        activityIndicator.startAnimating()
        networkService.getCurrentWeatherForecast(city: currentCity)
        activityIndicator.stopAnimating()
    }
    
    //отслеживание изменений
    private func setupNotificationToken() {
        notificationToken = forecastItems?.observe {[weak self] change in
            guard let self = self else { return }
            switch change {
            case .error(let error):
                self.showError(error)
            case .initial:
                self.collectionView.reloadData()
            case .update:
                self.collectionView.reloadData()
            }
        }
    }
}

extension ForecastViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        forecastItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resuseID, for: indexPath) as? ForecastCollectionViewCell else {
            fatalError("{Message: Error in dequeue CityTableViewCell}")
        }
        cell.delegate = self
        guard let forecastItems = forecastItems else { return UICollectionViewCell() }
        cell.configure(with: forecastItems[indexPath.row])
        return cell
    }
}

extension ForecastViewController: ForecastCollectionViewCellDelegate {
    func heartWasPressed(at objectID: UUID) {
        guard let object = try? databaseService.get(RealmWeather.self, primaryKey: objectID) else { return }
        let realm = try! Realm()
        try? realm.write {
            object.isLike.toggle()
        }
    }
}
