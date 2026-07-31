//
//  FavoriteViewConreoller.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 12.12.2025.
//
import UIKit
import SVProgressHUD
import Localize_Swift

class FavoriteViewController: UIViewController {
    lazy var navigationTitle = UILabel.createLabel(text: "favorite_vc_title".localized(),font: UIFont(name: Fonts.bold.rawValue, size: 16)!, color: Colors.Text.primary,textAlignment: .center, numberOfLines: 1)

    let viewModel = FavoriteViewModel()
    let mainView = MoviesListView()
    
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        //view.backgroundColor = .white
        view.backgroundColor = .primaryBackground
        navigationItem.titleView = navigationTitle
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        bindViewModel()
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)


    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavoriteMovies()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
    }
    
    
   
    
    private func bindViewModel(){
        viewModel.didUpdateMovies = { [weak self] in
            self?.mainView.tableView.reloadData()
        }
        viewModel.isLoading = { loading in
            loading ? SVProgressHUD.show() : SVProgressHUD.dismiss()
        }
    }
    
    @objc func languageDidChange(){
        navigationTitle.text = "favorite_vc_title".localized()
        mainView.tableView.reloadData()
    }
    

}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesCellView.id ,for: indexPath) as! MoviesCellView
        cell.setData(movie: viewModel.favoriteMovies[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}
