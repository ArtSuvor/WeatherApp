//
//  AnimateViewController.swift
//  WeatherApp
//
//  Created by Art on 10.08.2021.
//

import UIKit

class AnimateViewController: UIViewController {

    @IBOutlet var animationView: UIView!
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func runAnimation(_ sender: Any) {
        
        animate6()
        
    }
    
    private var isCardTurn = false
    private var propertyAnimator: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        animationView.addGestureRecognizer(panGR)
    }
    
    //переворачивание картинки по жесту движения
    @objc private func onPan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            //задаем анимацию
            let rotation = CATransform3DMakeRotation(.pi, 0, 1, 0)
            
            propertyAnimator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut, animations: {
                if !self.isCardTurn {
                    self.imageView.transform = CATransform3DGetAffineTransform(rotation)
                } else {
                    self.imageView.transform = .identity
                }
            })
            propertyAnimator.pauseAnimation()
            
        case .changed:
            //обращаемся к вью и расчитываем смещение пальца по вью
            let translation = recognizer.translation(in: animationView)
            let percent = translation.x / 100
            let animationPercent = min(1, max(0, percent))
            propertyAnimator.fractionComplete = animationPercent
            
        case .ended:
            propertyAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0.4)
            isCardTurn.toggle()
        default: break
        }
    }
    
    private func animate2() {
        let transform1 = CGAffineTransform(translationX: 150, y: 0)
        let transform2 = transform1.concatenating(CGAffineTransform(translationX: 0, y: 100))
        let transfotm3 = transform2.concatenating(CGAffineTransform(translationX: -150, y: 0))
        
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: [.repeat, .calculationModeLinear]) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                self.animationView.transform = transform1
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.animationView.transform = transform2
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                self.animationView.transform = transfotm3
            }
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                self.animationView.transform = .identity
            }
        }
    }
    
    private func animate3() {
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 1
        animationGroup.timingFunction = CAMediaTimingFunction(controlPoints: 0.8, 0.73, 0.48, 1)
        animationGroup.repeatCount = .infinity
        animationGroup.autoreverses = true
        
        let translationAnimation = CABasicAnimation(keyPath: "position.x")
        translationAnimation.fromValue = animationView.center.x
        translationAnimation.toValue = animationView.center.x + 200
        
        let fadeOutAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        fadeOutAnimation.fromValue = 1
        fadeOutAnimation.toValue = 0
        
        animationGroup.animations = [translationAnimation, fadeOutAnimation]
        animationView.layer.add(animationGroup, forKey: nil)
    }
/*
    private func animate4() {
         let pointLayer = CAShapeLayer()
        pointLayer.backgroundColor = UIColor.black.cgColor
        pointLayer.bounds = CGRect(x: 0, y: 0, width: 5, height: 5)
        pointLayer.position = CGPoint(x: 50, y: 50)
        animationView.layer.addSublayer(pointLayer)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path =
        animation.calculationMode = .cubic
        animation.duration = 2
        animation.repeatCount = .infinity
        pointLayer.add(animation, forKey: nil)
    }
 */
    private func animate6() {
        let rotation = CATransform3DMakeRotation(.pi, 0, 1, 0)
        
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.transform))
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.repeatCount = .infinity
        animation.autoreverses = true
        animation.fromValue = imageView.layer.transform
        animation.toValue = rotation
        imageView.layer.add(animation, forKey: nil)
    }
    
    
    
}
