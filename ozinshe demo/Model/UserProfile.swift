//
//  UserProfile.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 19.03.2026.
//

struct UserProfile: Codable{
    let id: Int
    let user: User
    let name: String
    let phoneNumber: String?
    let birthDate: String?
    var language: String?
}


struct User: Codable{
    let id: Int
    let email: String
}

struct UserProfileRequest: Codable{
    let birthDate: String
    let id: Int
    let language: String
    let name: String
    let phoneNumber: String
}

struct ChangePaswwordRequest: Codable{
    let password: String
}
