//
//  UIViewController+Ext.swift
//  WeatherApp
//
//  Created by Art on 17.09.2021.
//

import UIKit

extension UIViewController {
    func showError(_ error: Error) {
        let alertVC = UIAlertController(title: "Ошибка!", message: error.localizedDescription, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alertVC.addAction(okButton)
        present(alertVC, animated: true, completion: nil)
    }
    
    func showAlertError(title: String, message: String){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alertVC.addAction(okButton)
        present(alertVC, animated: true, completion: nil)
    }
}
