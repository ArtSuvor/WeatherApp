//
//  AnimationViewController.swift
//  WeatherApp
//
//  Created by Art on 07.08.2021.
//

import UIKit

class AnimationViewController: UIViewController {

    @IBOutlet var animationView: UIView!
    @IBOutlet var topAnimationViewConstraint: NSLayoutConstraint!
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showLayerAnimation()
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { //выставляем задержку перед анимацией
//            UIView.transition(with: self.label, duration: 1, options: .transitionCrossDissolve) { //замена текста на лейбе
//                self.label.text = "Hello"
//                self.label.font = UIFont(name: "Marker Felt", size: 20)
//            } completion: { _ in
//                self.animationView.isHidden = false
//                UIView.transition(from: self.label, to: self.animationView, duration: 1, options: .transitionCrossDissolve) // замена лейбы на вьюху
//            }
//        }
//
        
//        UIView.animate(withDuration: 1) {
//            self.animationView.frame.origin.x += 200
//            self.animationView.backgroundColor = .red
//            self.animationView.alpha = 0.5 //прозрачность
//        } completion: { _ in
//            self.backAnimation()
//        }
//    }
//
//
//    func backAnimation() {
//        UIView.animate(withDuration: 1, delay: 1) {
//            self.animationView.frame.origin.x -= 200
//            self.animationView.backgroundColor = .green
//            self.animationView.alpha = 1
//        }
        
//        UIView.animate(withDuration: 2, delay: 0.1, options: .curveEaseInOut) {
//            self.topAnimationViewConstraint.constant = 250
//            self.view.layoutIfNeeded() //вызывается для анимации констрейнов, говорим что сейчас будут обновления и надо обновить вьюху
//        }
        
        //пружинная анимация
//        UIView.animate(withDuration: 5, delay: 0.1, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: []) {
//            self.topAnimationViewConstraint.constant = 250
//            self.view.layoutIfNeeded()
//        }
    }
    
    private func showLayerAnimation() {
//        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
//        animation.beginTime = CACurrentMediaTime()
//        animation.fromValue = 0.5
//        animation.toValue = 1
//        animation.duration = 3
//        animationView.layer.add(animation, forKey: nil)
        
        let animation = CASpringAnimation(keyPath: "position.x")
        animation.fromValue = 50
        animation.toValue = 250
        animation.mass = 0.5
        animation.stiffness = 10
        animation.duration = 2
        animationView.layer.add(animation, forKey: nil)
    }
    
    private func setupView() {
        animationView.backgroundColor = .green
        animationView.frame = CGRect(x: 50, y: 100, width: 70, height: 70)
        view.addSubview(animationView)
    }
}
