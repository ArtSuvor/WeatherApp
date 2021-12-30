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
    
    //MARK: - Properties

    var currentCity = ""
    private var forecastItems: [Weather]?
    private let refControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    //MARK: - Сервисы
    private let networkService = WeatherOperationQueue()

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Прогноз"
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(ForecastCollectionViewCell.self, forCellWithReuseIdentifier: ForecastCollectionViewCell.reuseID)
        moveActivitiIndicator()
        setRefControl()
    }
    
    //MARK: - Functions
    private func setRefControl() {
        refControl.addTarget(self, action: #selector(fetchForecast), for: .valueChanged)
        collectionView.refreshControl = refControl
    }

    private func moveActivitiIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.frame = CGRect(x: view.center.x, y: view.frame.midY + 20, width: 45, height: 45)
        activityIndicator.startAnimating()
        fetchForecast()
    }
    
    @objc private func fetchForecast() {
        networkService.getWeather(city: currentCity) {[weak self] weathers in
            guard let self = self else { return }
            self.forecastItems = weathers
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
            self.refControl.endRefreshing()
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
        let itemTwo = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        itemTwo.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 3, bottom: 3, trailing: 3)
        let groupHoriz = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2)), subitems: [item, itemTwo])
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [groupHoriz])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 3
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
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
