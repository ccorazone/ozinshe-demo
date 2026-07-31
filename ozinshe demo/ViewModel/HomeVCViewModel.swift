//
//  HomeVCViewModel.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 07.04.2026.
//

import Foundation

@MainActor
class HomeVCViewModel{
    private let networkService = NetworkManager.shared
    private(set) var sections: [HomeSection] = []
    var onError: ((String?) -> Void)?
    var isLoading: ((Bool) -> ())?
    var onDataLoaded: (() -> ())?
    
    func fetchHomeData() async {
        isLoading?(true)
        
        defer{
            isLoading?(false)
        }
        
        do{
            async let banners = networkService.fetchAllBanners()
            async let watchHistory = networkService.fetchWatchHistory()
            async let categories = networkService.fetchAllMoviesWithCategory()
            async let genres = networkService.fetchAllGenres()
            async let ageCategories = networkService.fetchAgeCategories()
            
            let (b,wh,cat,g,ag) = try await (banners, watchHistory, categories, genres, ageCategories)
           
            var allSections: [HomeSection] = []
            allSections.append(.mainBanners(b))
            if !wh.isEmpty{
                allSections.append(.continueWatching(wh))
            }
            cat.forEach { (category) in
                allSections.append(.moviesSelection(category))
            }
            
            let genreIndex = min(allSections.count, 4)
            allSections.insert(.genres(g), at: genreIndex)
            let ageIndex = min(allSections.count, 9)
            allSections.insert(.ageCategories(ag), at: ageIndex)
            self.sections = allSections
            onDataLoaded?()
            
        }catch{
            onError?(error.localizedDescription)
        }
    }
    
    func numberOfItems(in sectionIndex: Int) -> Int{
        guard sectionIndex < sections.count else{
            return 0
        }
        let section = sections[sectionIndex]
        switch section{
        case .mainBanners(let banners):
            return banners.count
        case .continueWatching(let movies):
            return movies.count
        case .moviesSelection(let category):
            return category.movies.count
        case .genres(let genre):
            return genre.count
        case .ageCategories(let ageCategories):
            return ageCategories.count
        }
        
    
    }
}
