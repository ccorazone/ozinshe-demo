//
//  AuthResponse.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 01.03.2026.
//

struct AuthResponse: Decodable{
    let id: Int
    let username: String
    let email: String
    let roles: [String]
    let tokenType: String
    let accessToken: String
}
