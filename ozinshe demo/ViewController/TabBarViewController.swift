//
//  TabBatViewController.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 12.12.2025.
//
import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
//        for family in UIFont.familyNames.sorted() {
//            let name = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names - \(name)")
//        }
    }
    
    func setupTabs(){
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let favoriteVC = FavoriteViewController()
        let profileVC = ProfileViewController()
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let searchNav = UINavigationController(rootViewController: searchVC)
        let favoriteNav = UINavigationController(rootViewController: favoriteVC)
        let profileNav = UINavigationController(rootViewController: profileVC)
        
        homeNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Home"), selectedImage: UIImage(named: "HomeSelected"))
        searchNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Search"), selectedImage: UIImage(named: "SearchSelected"))
        favoriteNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Favorite"), selectedImage: UIImage(named: "FavoriteSelected"))
        profileNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Profile"), selectedImage: UIImage(named: "ProfileSelected"))
        
        setViewControllers( [homeNav, searchNav, favoriteNav, profileNav], animated: true)

    }
}

