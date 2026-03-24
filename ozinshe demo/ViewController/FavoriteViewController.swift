//
//  FavoriteViewConreoller.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 12.12.2025.
//
import UIKit
import SVProgressHUD

class FavoriteViewController: UITableViewController {
    lazy var navigationTitle = UILabel.createLabel(text: "Тізім",font: UIFont(name: Fonts.bold.rawValue, size: 16)!, color: Colors.Text.primary,textAlignment: .center)

    let viewModel = FavoriteViewModel()
    override func viewDidLoad() {
    
        super.viewDidLoad()
        //view.backgroundColor = .white
        view.backgroundColor = .primaryBackground
        navigationItem.titleView = navigationTitle
        tableView.register(MoviesCellView.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .primaryBackground
        bindViewModel()


    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavoriteMovies()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoriteMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath) as! MoviesCellView
        cell.setData(movie: viewModel.favoriteMovies[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    private func bindViewModel(){
        viewModel.didUpdateMovies = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.isLoading = { loading in
            loading ? SVProgressHUD.show() : SVProgressHUD.dismiss()
        }
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 153
//    }
}
