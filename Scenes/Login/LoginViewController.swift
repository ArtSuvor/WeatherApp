//
//  ViewController.swift
//  WeatherApp
//
//  Created by Art on 16.07.2021.
//

import UIKit

class LoginViewController: UIViewController {
    //MARK: - Outlets
    ///scrollView
    @IBOutlet var scrollView: UIScrollView!
    ///login
    @IBOutlet var loginTextField: UITextField!
    ///password
    @IBOutlet var passwordTextField: UITextField!
    ///кнопка входа
    @IBOutlet var authButton: UIButton!
    
    //MARK: - Properties
    private let animator = Animator()

    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //подключаем наблюдателя для показа/скрытия клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateAuthButton()
    }
    
    //MARK: - Functions
    ///сега перехода на след экран
    @IBAction func pushCurrentVC(_ sender: Any) {
        performSegue(withIdentifier: "showMainScreenID", sender: nil)
    }
    //проверяем то ли вью и результат авторизации
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "showMainScreenID" && checkAuth() {
            return true
        } else {
            showAuthError()
            return false
        }
    }
    
    //проверяем авторизацию пользователя
    func checkAuth() -> Bool {
        return (loginTextField.text ?? "").isEmpty && (passwordTextField.text ?? "").isEmpty
    }
    
    //уведомление пользователя об ошибке
    func showAuthError() {
        let alertVC = UIAlertController(title: "Error", message: "Write password", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    //показ клавиатуры
    @objc func keyboardWasShow(_ notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let keyboardSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        
        self.scrollView?.contentInset = contentInset
        scrollView?.scrollIndicatorInsets = contentInset
    }
    
    //скрытие клавиатуры
    @objc func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = .zero
    }
    
    //анимация кнопки входа
    private func animateAuthButton() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = .backwards
        authButton.layer.add(animation, forKey: nil)
    }
}

extension LoginViewController: UIViewControllerTransitioningDelegate {

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator
    }
}
