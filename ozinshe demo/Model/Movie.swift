//
//  Movie.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 12.03.2026.
//

struct Movie: Codable{
    let id: Int
    let movieType: String
    let name: String
    let keyWords: String?
    let description: String?
    let year: Int?
    let trend: Bool?
    let timing: Int?
    let director, producer: String?
    let poster: Poster?
    let video: Video?
    let watchCount, seasonCount, seriesCount: Int?
    let createdDate, lastModifiedDate: String?
    let screenshots: [Poster]
    let categoryAges, genres, categories: [Category]
    let favorite: Bool
}

struct Category: Codable{
    let id: Int
    let name: String
    let fileId: Int?
    let link: String?
    let movieConut: Int?
    
}
struct Poster: Codable{
    let id: Int
    let link: String?
    let fileId: Int?
    let movieId: Int?
}

struct Video: Codable{
    let id: Int
    let link: String?
    let seasonId: Int?
    let number: Int?
    
}

