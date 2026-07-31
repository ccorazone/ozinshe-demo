//
//  CategoryResponse.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 31.03.2026.
//

import Foundation

struct CategoryResponse: Codable {
    let id: Int
    let name: String
    let fileId: String?
    let link: String?
    let movieCount: Int?
}
