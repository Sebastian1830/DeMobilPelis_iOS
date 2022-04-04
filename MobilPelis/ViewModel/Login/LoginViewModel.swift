//
//  LoginViewModel.swift
//  MobilPelis
//
//  Created by Sebastian Soto Varas on 2/04/22.
//

import Foundation

class LoginViewModel: NSObject {
    typealias authLoginCallback = (_ status: Bool, _ message: String) -> Void
    var loginCallback: authLoginCallback?
    
    public func validateFields(_ username: String, _ password: String) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            if username.count > 0  && password.count > 0 {
                self.validateUser(username, password)
            } else {
                self.loginCallback?(false, "Datos Incorrectos")
            }
        }
    }
    
    private func validateUser(_ username: String, _ password: String) {
        if username == "Admin" && password == "Password*123" {
            self.loginCallback?(true, "Login Correcto")
        } else {
            self.loginCallback?(false, "Login Incorrecto")
        }
    }
    
    public func loginCompletationHandler(callback: @escaping authLoginCallback) {
        self.loginCallback = callback
    }
}
