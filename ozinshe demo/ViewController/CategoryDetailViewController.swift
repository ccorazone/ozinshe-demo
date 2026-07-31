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


class CategoryDetailViewController: UIViewController{
    
    let mainView = MoviesListView()
    let viewModel = CategoryDetailViewModel()
    
    lazy var navigationTitle = UILabel.createLabel(font: UIFont(name: Fonts.bold.rawValue, size: 16)!, color: Colors.Text.primary,textAlignment: .center, numberOfLines: 1)

    
    override func loadView() {
        view = mainView
        
    }
    
    init(categoryId: Int, categoryName: String){
        self.viewModel.getMoviesByCategory(categoryId: categoryId)
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
        self.navigationTitle.text = categoryName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = navigationTitle
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        bindingVC()
        //viewModel.getMoviesByCategory(categoryId: <#T##Int#>)
        
    }
    
    
    private func bindingVC(){
        viewModel.didMoviesLoaded = { [weak self] in
            self?.mainView.tableView.reloadData()
        }
        
        viewModel.isLoaded = {[weak self] loading in
            loading ? SVProgressHUD.show() : SVProgressHUD.dismiss()
        }
    }
    

    
    
}


extension CategoryDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.arrayOfMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesCellView.id ,for: indexPath) as! MoviesCellView
        cell.setData(movie: viewModel.arrayOfMovies[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    
}
