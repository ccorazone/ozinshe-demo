//
//  HomeSection.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 07.04.2026.
//
enum HomeSection{
    case mainBanners([BannerMovie])
    case continueWatching([Movie])
    case moviesSelection(AllMoviesByCategory)
    case genres([Genre])
    case ageCategories([AgeCategories])
}
