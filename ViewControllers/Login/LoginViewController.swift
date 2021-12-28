//
//  ViewController.swift
//  WeatherApp
//
//  Created by Art on 16.07.2021.
//

import UIKit
import FirebaseAuth

final class LoginViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var authButton: UIButton!
    
    //MARK: - Properties
    private var handle: AuthStateDidChangeListenerHandle!
    private let animator: Animator = Animator()

    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //подключаем наблюдателя для показа/скрытия клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        addingAuthListener()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateAuthButton()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    //MARK: - Functions
    ///сега перехода на след экран
    @IBAction func pushCurrentVC(_ sender: Any) {
        guard let email = loginTextField.text,
              let password = passwordTextField.text,
              !email.isEmpty,
              !password.isEmpty else { return showAlertError(title: "Ошибка", message: "Логин или пароль некорректны") }
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] user, error in
            if let error = error, user == nil {
                self?.showError(error)
            }
        }
    }
    
    @IBAction func singButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "Регистрация", message: "Регистрация пользователя", preferredStyle: .alert)
        
        alert.addTextField { login in
            login.placeholder = "Введите Email"
        }
        alert.addTextField { password in
            password.placeholder = "Введите пароль"
            password.isSecureTextEntry = true
        }
        
        let regButton = UIAlertAction(title: "Зарегистрировать", style: .default) {[weak self] _ in
            guard let emailField = alert.textFields?[0],
                  let passwordField = alert.textFields?[1],
                  let email = emailField.text,
                  let password = passwordField.text else { return } 
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
                if let error = error {
                    self?.showError(error)
                } else {
                    Auth.auth().signIn(withEmail: email, password: password)
                }
            }
        }
        let cancelButton = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(regButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
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
    
    private func addingAuthListener() {
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "showMainScreenID", sender: nil)
                self.loginTextField.text = nil
                self.passwordTextField.text = nil
            }
        }
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
