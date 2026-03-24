//
//  PasswordPesponse.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 20.03.2026.
//

struct PasswordPesponse: Codable{
    let id: Int
    let username: String
    let email: String
    let roles: [String]
    let tokenType: String
    let accessToken: String
}
