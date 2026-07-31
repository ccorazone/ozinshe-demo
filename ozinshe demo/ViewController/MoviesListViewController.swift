//
//  CategoryDetailViewController.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 01.04.2026.
//
import UIKit
import SnapKit
import Localize_Swift
import SVProgressHUD


class MoviesListViewController: UIViewController{
    
    let mainView = MoviesListView()
    
    lazy var navigationTitle = UILabel.createLabel(font: UIFont(name: Fonts.bold.rawValue, size: 16)!, color: Colors.Text.primary,textAlignment: .center, numberOfLines: 1)
    var movies: [Movie]
    
    override func loadView() {
        view = mainView
        
    }
    
    init(title: String, movies: [Movie]){
        self.movies = movies
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true

        self.navigationTitle.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = navigationTitle
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
    }
    
    
}


extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesCellView.id ,for: indexPath) as! MoviesCellView
        cell.setData(movie: movies[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    
}
