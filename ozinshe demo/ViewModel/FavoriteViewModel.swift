//
//  FavoriteViewModel.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 12.03.2026.
//
import Foundation
class FavoriteViewModel{
    var favoriteMovies: [Movie] = []
    
    var isLoading: ((Bool) -> Void)?
    var didUpdateMovies: (() -> Void)?
    var didGetError: ((String) -> Void)?
    
    func fetchFavoriteMovies(){
        if favoriteMovies.isEmpty {
            isLoading?(true)

        }
        NetworkManager.shared.loadFavorite{ [weak self] result, error in
            
            DispatchQueue.main.async {
                self?.isLoading?(false)
                
                if let error = error {
                    self?.didGetError?(error)
                    return
                }
                
                if let movies = result {
                    self?.favoriteMovies = movies
                    self?.didUpdateMovies?()
                }
            }
            
        }
    }
}
