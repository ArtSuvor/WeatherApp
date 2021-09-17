//
//  UITableView+Ext.swift.swift
//  WeatherApp
//
//  Created by Art on 17.09.2021.
//

import UIKit

extension UITableView {
    func updateChanges(deletions: [Int], insertions: [Int], modifications: [Int], section: Int = 0) {
        beginUpdates()
        deleteRows(at: deletions.map {IndexPath(row: $0, section: section)}, with: .fade)
        insertRows(at: insertions.map {IndexPath(row: $0, section: section)}, with: .fade)
        reloadRows(at: modifications.map {IndexPath(row: $0, section: section)}, with: .automatic)
        endUpdates()
    }
}
