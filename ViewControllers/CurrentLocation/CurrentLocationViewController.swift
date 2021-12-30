//
//  CurrentLocationViewController.swift
//  WeatherApp
//
//  Created by Art on 30.12.2021.
//

import UIKit

class CurrentLocationViewController: UIViewController {
    
//MARK: - UI elements
    private var tableView: UITableView!
    
//MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
//MARK: - Methods
    private func setTableView() {
        view.backgroundColor = .secondarySystemBackground
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CurrentLocationHeader.self, forHeaderFooterViewReuseIdentifier: CurrentLocationHeader.reuseId)
        tableView.register(CurrentLocationTableCell.self, forCellReuseIdentifier: CurrentLocationTableCell.reuseId)
        view.addSubview(tableView)
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
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentLocationTableCell.reuseId, for: indexPath) as? CurrentLocationTableCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

