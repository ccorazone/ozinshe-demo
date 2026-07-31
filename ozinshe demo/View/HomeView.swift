//
//  HomeView.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 08.04.2026.
//
import UIKit
import SnapKit
import Localize_Swift


class HomeView: UIView{
    
    var sections: [HomeSection] = []
    
    lazy var logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "purpleLogo")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    lazy var logoTextImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logoText")
        iv.tintColor = Colors.Text.defaultBlack
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [logoImageView, logoTextImageView])
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.alignment = .center
        
        stackView.backgroundColor = .grey100
        stackView.layer.cornerRadius = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return stackView
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: createLayout())
        collectionView.backgroundColor = Colors.View.primaryBackground
        return collectionView
    }()
    
    init(){
        super.init(frame: .zero)
        setupUI()
        setConstrints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func createLayout() -> UICollectionViewCompositionalLayout{
        UICollectionViewCompositionalLayout{ [weak self] sectionIndex, _ in
            //return self?.createBannerSection()
            guard let self = self else {
                return self?.createBannerSection()
            }
            let section = self.sections[sectionIndex]
            switch section{
            case .mainBanners:
                return self.createBannerSection()
            case .continueWatching:
                return self.createContinueWatchingSection()
            case .moviesSelection:
                return self.createAllMoviesSection()
            case .genres:
                return createCardSection()
            case .ageCategories:
                return createCardSection()
            }
            
        }
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection{
        let item: NSCollectionLayoutItem = .init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .estimated(240))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 32, leading: 24, bottom: 32, trailing: 24)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func createContinueWatchingSection() -> NSCollectionLayoutSection{
        let item: NSCollectionLayoutItem = .init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(156))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        header.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16

        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 32, trailing: 24)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }

    private func createAllMoviesSection() -> NSCollectionLayoutSection{
        let item: NSCollectionLayoutItem = .init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .estimated(224))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        header.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 24, bottom: 32, trailing: 24)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    private func createCardSection() -> NSCollectionLayoutSection{
        let item: NSCollectionLayoutItem = .init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(112))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.boundarySupplementaryItems = [header]
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 24, bottom: 32, trailing: 24)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }

    
    private func setupUI(){
        self.addSubview(collectionView)
    }
    
    private func setConstrints(){
        logoImageView.snp.makeConstraints{make in
            make.width.equalTo(13)
            make.height.equalTo(17)
        }
        logoTextImageView.snp.makeConstraints{make in
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints{ make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
    
    
    
    
}
