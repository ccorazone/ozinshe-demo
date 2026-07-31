//
//  SearchCategoriesViewModel.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 31.03.2026.
//
import Foundation

class SearchCategoriesViewModel {
    var categories: [CategoryResponse] = []
    var moviesByQuery: [Movie] = []
    var didLoaded: (() -> Void)?
    
    var didSearchLoaded: (() -> ())?
    var didShowLoader: ((Bool) -> ())?
    
    func fetchCategories(){
        NetworkManager.shared.fetchCategories{[weak self] response in
            DispatchQueue.main.async {
                
                if let response = response {
                    self?.categories = response
                    self?.didLoaded?()
                }
            }
        }
    }
    
    func getMoviesBy(query: String){
        didShowLoader?(true)
        NetworkManager.shared.fetchMoviesByQuery(query: query){[weak self] response, error in
            DispatchQueue.main.async {
                self?.didShowLoader?(false)
                if let movies = response {
                    self?.moviesByQuery = movies
                    self?.didSearchLoaded?()
                }
                
            }
        }
    }
}
