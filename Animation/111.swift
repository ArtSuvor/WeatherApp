import UIKit


class PhotoView: UIViewController {
    
    private var animator: UIViewPropertyAnimator = {
        UIViewPropertyAnimator(duration: 3, curve: .linear)
    }()
    private var index = 0
    private var photoFullScreen = []
    
    @objc private func swipeImage(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            swipe()
            animator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: view)
            let percent = translation.x / 100
            let animationPercent = min(1, max(0, percent))
            animator.fractionComplete = animationPercent
        case .ended:
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0.5)
        default: break
        }
    }
    
    private func swipe() {
        animator.addAnimations {
            v
        UIView.transition(with: self.photoImageView, duration: 3, options: .curveLinear) {
            let animate = CASpringAnimation(keyPath: "transform.scale")
            animate.fromValue = 1
            animate.toValue = 0.9
            animate.duration = 1.5
            animate.mass = 1
            
            let swipe = CATransition()
            swipe.type = .push
            swipe.subtype = .fromLeft
            swipe.duration = 1.5
            self.photoImageView.layer.add(swipe, forKey: nil)
            self.photoImageView.layer.add(animate, forKey: nil)
            
            if self.index == 0 {
                self.index = self.photosFullScreen.count - 1
            } else {
                self.index -= 1
            }
            self.photoImageView.image = self.photosFullScreen[self.index].image
        }
        }
    }
    
    private func setupRecognizer() {
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(swipeImage(_:)))
        view.addGestureRecognizer(panGR)
    }
    
}
