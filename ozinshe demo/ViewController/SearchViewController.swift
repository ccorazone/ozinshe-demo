//
//  SearchViewController.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 12.12.2025.
//
import UIKit
import Localize_Swift
import SVProgressHUD

class SearchViewController: UIViewController {
    
    lazy var navigationTitle = UILabel.createLabel(text: "search_title".localized(),font: UIFont(name: Fonts.bold.rawValue, size: 16)!, color: Colors.Text.primary,textAlignment: .center, numberOfLines: 1)
    
    let viewModel = SearchCategoriesViewModel()
    let mainView = SearchView()
    
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .white
        view.backgroundColor = .primaryBackground
        navigationItem.titleView = navigationTitle
        bindingVC()
        readTextFromTextField()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.searchTextField.delegate = self
        
        mainView.moviesTableView.tableView.delegate = self
        mainView.moviesTableView.tableView.dataSource = self
        
        
        viewModel.fetchCategories()
        hideKeyboard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)

    }
    
    
    private func bindingVC(){
        viewModel.didLoaded = {[weak self] in
            self?.mainView.collectionView.reloadData()
        }
        
        viewModel.didSearchLoaded = {[weak self] in
            self?.mainView.moviesTableView.tableView.reloadData()
        }
        viewModel.didShowLoader = { loading in
            loading ? SVProgressHUD.show() : SVProgressHUD.dismiss()
        }
    }
    
    private func readTextFromTextField(){
        mainView.onSearchTextChanged = {[weak self] text in
            if text.isEmpty{
                self?.mainView.collectionView.isHidden = false
                self?.mainView.moviesTableView.isHidden = true
                //self?.tabBarController?.tabBar.isHidden = false
                self?.hideTabBar(hide: false)
                self?.mainView.titleLabel.text = "search_title".localized()
            }else{
                self?.mainView.collectionView.isHidden = true
                self?.mainView.moviesTableView.isHidden = false
                //self?.tabBarController?.tabBar.isHidden = true
                self?.hideTabBar(hide: true)
                self?.mainView.titleLabel.text = "search_results".localized()
            }
            
            self?.viewModel.getMoviesBy(query: text)
        }
    }
    private func hideKeyboard(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func languageDidChange(){
        navigationTitle.text = "search_title".localized()
        mainView.updateLocalization()
    }
    
    private func hideTabBar(hide: Bool){
        guard let tabBar = tabBarController?.tabBar else { return }
        //tabBar.isHidden = hide ? true : false
        let screenHeight = UIScreen.main.bounds.height
        let newY = hide ? screenHeight : screenHeight - tabBar.frame.height
        
        UIView.animate(withDuration: 0.3, animations: {
            tabBar.frame.origin.y = newY
            tabBar.alpha = hide ? 0 : 1
        })
        
        mainView.moviesTableView.snp.remakeConstraints({ make in
            make.top.equalTo(mainView.titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            if hide{
                make.bottom.equalToSuperview()
                
            }else{
                make.bottom.equalTo(mainView.safeAreaLayoutGuide.snp.bottom)
            }
        })
        
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
    }
}


extension SearchViewController: UICollectionViewDelegate{
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = viewModel.categories[indexPath.row]
        let vc = CategoryDetailViewController(categoryId: selectedCategory.id, categoryName: selectedCategory.name)
        
        navigationController?.show(vc, sender: self)
    }
}

extension SearchViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.id, for: indexPath) as! CategoryCell
        let category =  viewModel.categories[indexPath.row].name
        cell.setData(category: category)
        return cell
    }
    
    
}

extension SearchViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        mainView.setTextFieldActive(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        mainView.setTextFieldActive(false)
    }
}

extension SearchViewController: UITableViewDelegate{
    
}
extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.moviesByQuery.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesCellView.id, for: indexPath) as! MoviesCellView
        let movies = viewModel.moviesByQuery[indexPath.row]
        cell.setData(movie: movies)
        return cell
        
    }
    
    
}

//extension SearchViewController: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let categoryName = viewModel.categories[indexPath.row].name
//        let font = UIFont(name: Fonts.semibold.rawValue, size: 12) ?? UIFont.systemFont(ofSize: 12)
//        let attributes = [NSAttributedString.Key.font: font]
//        let size = (categoryName as NSString).size(withAttributes: attributes)
//        return CGSize(width: size.width + 32, height: 34)
//        
//    }
//}
