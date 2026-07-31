//
//  HomeViewController.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 12.12.2025.
//
import UIKit
import SnapKit
import SVProgressHUD
import Localize_Swift

class HomeViewController: UIViewController{
    
    private let vm = HomeVCViewModel()
    private let mainView = HomeView()
    
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .white
        view.backgroundColor = .primaryBackground
        setNavBarView()
        bindVC()
        regiserCells()
        registerHeaderCells()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task{
            await vm.fetchHomeData()
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
    }
    
    private func bindVC(){
        vm.isLoading = { active in
            active ? SVProgressHUD.show() : SVProgressHUD.dismiss()
        }
        vm.onDataLoaded = {[weak self] in
            guard let self = self else {return }
            self.mainView.sections = self.vm.sections
            self.mainView.collectionView.reloadData()
            
        }
    }
    private func setNavBarView(){
        let containerView = UIView()
        //containerView.isUserInteractionEnabled = false
        containerView.addSubview(mainView.stackView)
        mainView.stackView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
        }
        
        navigationItem.titleView = containerView
        
        
    }
    private func regiserCells(){
        mainView.collectionView.register(HomeBannerCell.self, forCellWithReuseIdentifier: HomeBannerCell.reuseId)
        mainView.collectionView.register(WatchHistoryCell.self, forCellWithReuseIdentifier: WatchHistoryCell.reuseId)
        mainView.collectionView.register(MoviesWithCategoryCell.self, forCellWithReuseIdentifier: MoviesWithCategoryCell.reuseId)
        mainView.collectionView.register(PosterAndTitleCell.self, forCellWithReuseIdentifier: PosterAndTitleCell.reuseId)
        
        
    }
    
    private func registerHeaderCells(){
        mainView.collectionView.register(SectionHeaderView.self,
                                         forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                         withReuseIdentifier: SectionHeaderView.reuseId)

    }
    
}

extension HomeViewController: UICollectionViewDelegate{
    
}

extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = vm.numberOfItems(in: section)
        return count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let count = vm.sections.count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = vm.sections[indexPath.section]
        switch sectionType{
        case .mainBanners(let banners):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBannerCell.reuseId, for: indexPath) as! HomeBannerCell
            let item = banners[indexPath.row]
            cell.setData(bannerMovie: item)
            return cell
            
        case .continueWatching(let movies):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WatchHistoryCell.reuseId, for: indexPath) as! WatchHistoryCell
            let item = movies[indexPath.row]
            cell.setData(movie: item)
            return cell
            
        case .moviesSelection(let categories):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesWithCategoryCell.reuseId, for: indexPath) as! MoviesWithCategoryCell
            let item = categories.movies[indexPath.row]
            cell.setData(movie: item)
            return cell
        case .genres(let genres):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterAndTitleCell.reuseId, for: indexPath) as! PosterAndTitleCell
            let item = genres[indexPath.row]
            cell.setData(data: item)
            return cell
        case .ageCategories(let ageCategories):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterAndTitleCell.reuseId, for: indexPath) as! PosterAndTitleCell
            let item = ageCategories[indexPath.row]
            cell.setData(data: item)
            return cell
            
        }
                    
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch vm.sections[indexPath.section] {
        case .genres(let genres):
            openDetailVC(id: genres[indexPath.row].id, title: genres[indexPath.row].name)
        case .ageCategories(let ageCategories):
            openDetailVC(id: ageCategories[indexPath.row].id, title: ageCategories[indexPath.row].name)
        default :
            return
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: SectionHeaderView.reuseId,
                                                                         for: indexPath) as! SectionHeaderView
            let section = vm.sections[indexPath.section]
            switch section{
            case .mainBanners:
                header.setTitle("")
            case .continueWatching:
                header.setTitle("continue_watch".localized())
            case .moviesSelection(let movie):
                header.setTitle(movie.categoryName, showAllLabel: true)
            case .genres:
                header.setTitle("choose_genre".localized())
            case .ageCategories:
                header.setTitle("for_age".localized())
            }
            header.onViewPressed = { [weak self] in
                switch section{
                case .moviesSelection(let movie):
                    self?.openDeatailVC(title: movie.categoryName, movie: movie.movies)
                default :
                    return
                }
                
                
                
            }
            
            return header
            
        }
        return UICollectionReusableView()
    }
    
    private func openDetailVC(id: Int, title: String){
        let vc = CategoryDetailViewController(categoryId: id , categoryName: title)
        navigationController?.show(vc, sender: self)
    }
    
    
    private func openDeatailVC(title: String, movie: [Movie]){
        let vc = MoviesListViewController(title: title, movies: movie)
        navigationController?.show(vc, sender: self)
    }
    
}
