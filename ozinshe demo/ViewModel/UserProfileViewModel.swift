//
//  UserProfileViewModel.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 19.03.2026.
//
import Foundation

class UserProfileViewModel {
    
    var didUpdateProfile: (() -> Void)?

    var userProfile: UserProfile?{
        didSet{
            didUpdateProfile?()
            
        }
    }
    
    func fetchProfile(){
        NetworkManager.shared.getUserProfile { [weak self] profile,error in
            DispatchQueue.main.async{
                if let profile = profile{
                    self?.userProfile = profile
                }
            }
        }
    }
    
    func updateProfile(birthDate: String, id: Int, language: String, name: String, phoneNumber: String,completion: @escaping (Bool)-> ()){
        let profile = UserProfileRequest(birthDate: birthDate, id: id, language: language, name: name, phoneNumber: phoneNumber)
        NetworkManager.shared.updateUserProfile(profile: profile){ [weak self] response in
            DispatchQueue.main.async{
                if let response = response {
                    self?.userProfile = response
                    completion(true)
                }
                else{
                    completion(false)
                }
            }
        }
        
    }
}

