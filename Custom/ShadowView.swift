//
//  ShadowView.swift
//  WeatherApp
//
//  Created by Art on 02.08.2021.
//

import UIKit

@IBDesignable class ShadowView: UIView {
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            updateShadowColor()
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            updateShadowRadius()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: shadowRadius).cgPath
    }
    
    private func commonInit() {
        updateShadowColor()
        updateShadowRadius()
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
    }
    
    private func updateShadowColor() {
        layer.shadowColor = shadowColor.cgColor
    }
    
    private func updateShadowRadius() {
        layer.shadowRadius = shadowRadius
    }
}
