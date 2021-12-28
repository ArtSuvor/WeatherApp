//
//  UIViewController+Ext.swift
//  WeatherApp
//
//  Created by Art on 17.09.2021.
//

import UIKit

extension UIViewController {
    func showError(_ error: String) {
        let alertVC = UIAlertController(title: "Ошибка!", message: error, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alertVC.addAction(okButton)
        present(alertVC, animated: true, completion: nil)
    }
}
