//
//  LoginViewModel.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 05.03.2026.
//

import Foundation

class LoginViewModel {
    
    var onError: ((String?) -> ())?
    var onSuccess: (() -> ())?
    var isLoading: ((Bool) -> ())?
    
    func login(username: String?, password: String?) {
        guard let username = username, !username.isEmpty, let password = password, !password.isEmpty else{
            onError?("Please fill in the required fields")
            return}
        if !username.contains("@") {
            onError?("Введите корректный email")
            return
        }else{
            onError?(nil)
        }
        isLoading?(true)
        let login = LoginRequest(email: username, password: password)
        NetworkManager.shared.loginRequest(userData: login) {[weak self] (result) in
            //self?.
            DispatchQueue.main.async{
                self?.isLoading?(false)
                if result{
                    
                    self?.onSuccess?()
                }
                else{
                    self?.onError?("Ошибка логина или пароля")
                }
            }
        }
        
    }
}
