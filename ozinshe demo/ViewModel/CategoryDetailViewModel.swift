//
//  CategoryDetailViewModel.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 01.04.2026.
//
import Foundation

class CategoryDetailViewModel{
    
    var arrayOfMovies: [Movie] = []
    var didMoviesLoaded: (() -> Void)?
    var isLoaded: ((Bool) -> ())?
    var didGetError: ((String) -> ())?
    
    func getMoviesByCategory(categoryId: Int){
        isLoaded?(true)
        NetworkManager.shared.fetchMoviesByCategory(categoryId: categoryId, completion: { [weak self] (movies, error) in
            DispatchQueue.main.async {

                self?.isLoaded?(false)
                
                if let error = error{
                    self?.didGetError?(error)
                    return
                }
                if let movies = movies{
                    self?.arrayOfMovies = movies
                    self?.didMoviesLoaded?()
                    
                }
                
            }
        })
    }
    
    
}
