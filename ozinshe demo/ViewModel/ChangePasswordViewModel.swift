//
//  ChangePasswordViewModel.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 20.03.2026.
//
import Foundation

class ChangePasswordViewModel{
    var didUpdated: (() -> ())?
    var onError: ((String) -> ())?
    func updatePassword(password: String){
        let password = ChangePaswwordRequest(password: password)
        NetworkManager.shared.changePassword(password: password){[weak self] result, error in
            DispatchQueue.main.async{
                if let error = error{
                    self?.onError?(error.localizedCapitalized)
                    return
                }
                if let result = result{
                    UserDefaults.standard.set(result.accessToken, forKey: "userToken")

                    self?.didUpdated?()
                }
            }
            
        }
    }
}
