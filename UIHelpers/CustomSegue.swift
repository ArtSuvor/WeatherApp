//
//  CustomSegue.swift
//  WeatherApp
//
//  Created by Art on 12.08.2021.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    
    private let animationDuration: TimeInterval = 1
    
    override func perform() {
        guard let containerView = source.view else {return}
        containerView.addSubview(destination.view)
        
        destination.view.frame = containerView.frame
        source.view.frame = containerView.frame
        
        destination.view.transform = CGAffineTransform(translationX: 0, y: source.view.bounds.height)
        
        UIView.animate(withDuration: animationDuration) {
            self.destination.view.transform = .identity
        } completion: { completed in
            self.destination.modalPresentationStyle = .fullScreen
            self.source.present(self.destination, animated: false)
        }
    }
}
