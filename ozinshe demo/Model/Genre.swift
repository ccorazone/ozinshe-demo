//
//  Genre.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 09.04.2026.
//

import Foundation

protocol Card{
    var id: Int { get }
    var name: String { get }
    var fileId: Int { get }
    var link: String { get }
    var movieCount: Int { get }
}

struct Genre: Codable, Card{
    let id: Int
    let name: String
    let fileId: Int
    let link: String
    let movieCount: Int
}

