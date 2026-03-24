//
//  AuthViewModel.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 03.03.2026.
//
import UIKit

class AuthViewModel{
    //var isLoading: ((Bool) -> Void)?
    //пока не понадобятся
    var onSuccess: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func register(email: String?, password: String?, confirmPassword: String? ){
        //self.isLoading?(true)
        guard let email = email, !email.isEmpty,
              let password = password, !password.isEmpty,
              let confirmPassword = confirmPassword, !confirmPassword.isEmpty else {
            self.onError?("Заполните все поля")
            return
        }
        if !email.contains("@") {
            self.onError?("неверный формат")
        }
        
        guard password == confirmPassword else {
            self.onError?("Пароли не совпадают")
            return
        }
        
        
        
        
        let user = SignUpRequest(email: email, password: password)
        NetworkManager.shared.signUpRequest(userData: user){[weak self] response, error in
            DispatchQueue.main.async{
                if let error = error{
                    self?.onError?("\(error)")
                }
                else if response != nil{
                    self?.onSuccess?()
                }
            }
        }
    
    }
}
