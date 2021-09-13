//
//  CustomNavigationController.swift
//  WeatherApp
//
//  Created by Art on 12.08.2021.
//

import UIKit

class CustomInterectiveTransition: UIPercentDrivenInteractiveTransition {
    var hasStarted = false
    var shouldFinish = false
}

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    let interectiveTransition = CustomInterectiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        let panGR = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handle(_:)))
        panGR.edges = .left
        view.addGestureRecognizer(panGR)
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        interectiveTransition.hasStarted ? interectiveTransition : nil
    }
    
//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
//        switch operation {
//        case .push:
//
//        case .pop:
//
//        default: return nil
//        }
//    }
    
    @objc private func handle(_ panGesture: UIScreenEdgePanGestureRecognizer) {
        switch panGesture.state {
        case .began:
            interectiveTransition.hasStarted = true
            self.popViewController(animated: true)
        case .changed:
            guard let widht = panGesture.view?.bounds.width else {
                interectiveTransition.hasStarted = false
                interectiveTransition.cancel()
                return
            }
            let translation = panGesture.translation(in: panGesture.view)
            let translationPercent = translation.x / widht
            let progress = max(0, min(1, translationPercent))
            interectiveTransition.update(progress)
            interectiveTransition.shouldFinish = progress > 0.5
        case .ended:
            interectiveTransition.hasStarted = false
            interectiveTransition.shouldFinish ? interectiveTransition.finish()
                                               : interectiveTransition.cancel()
        case .cancelled:
            interectiveTransition.hasStarted = false
            interectiveTransition.cancel()
        default: break
        }
    }
    
}
