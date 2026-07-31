//
//  AgeCategories.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 09.04.2026.
//

import Foundation

struct AgeCategories: Codable, Card {
    let id: Int
    let name: String
    let fileId: Int
    let link: String
    let movieCount: Int
}
