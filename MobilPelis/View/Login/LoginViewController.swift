//
//  LoginViewController.swift
//  MobilPelis
//
//  Created by Sebastian Soto Varas on 1/04/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    private var loginVM = LoginViewModel()
    
    @IBAction func loginAction(_ sender: Any) {
        validateCredentials()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginView()
    }
    
    private func setupLoginView() {
        LoginButton.layer.cornerRadius = 10
        LoginButton.layer.masksToBounds = true
    }
    
    private func validateCredentials() {
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        loginVM.validateFields(username, password)
        loginVM.loginCompletationHandler { (status, message) in
            if status {
                self.segueTo(storyboard: "ListMovie", controller: "ListMovieViewController", presentation: .fullScreen, transition: .coverVertical)
            } else {
                self.showToast(message: message, font: .systemFont(ofSize: 12.0))
            }
        }
    }
}
