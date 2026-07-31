//
//  MoviesWithCategory.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 09.04.2026.
//

import UIKit
import SnapKit
import SDWebImage

class MoviesWithCategoryCell: UICollectionViewCell {
    static let reuseId = "MoviesWithCategoryCell"
    
    lazy var posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    private lazy var movieNameLabel = UILabel.createLabel(font: UIFont(name: Fonts.semibold.rawValue, size: 12)!, color: Colors.Text.primary, numberOfLines: 2)
    private lazy var categoriesLabel = UILabel.createLabel(font: UIFont(name: Fonts.regular.rawValue, size: 12)!, color: Colors.Text.secondary, numberOfLines: 1)
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(){
       
        contentView.addSubview(posterImageView)
        contentView.addSubview(movieNameLabel)
        contentView.addSubview(categoriesLabel)
    }
    
    private func setConstraints(){
        posterImageView.snp.makeConstraints{make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(164)
        }
        movieNameLabel.snp.makeConstraints{make in
            make.top.equalTo(posterImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        categoriesLabel.snp.makeConstraints{make in
            make.top.equalTo(movieNameLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().priority(.low)
        }
    }
    func setData(movie: Movie){
        if let link = movie.poster?.link{
            let temp = link.replacingOccurrences(of: "api.ozinshe.com", with: "apiozinshe.mobydev.kz")
            posterImageView.sd_setImage(with: URL(string: temp))
        }else{
            posterImageView.image = UIImage(named: "Image")
        }
        movieNameLabel.text = movie.name
        let categories = (movie.categories ?? []).map { $0.name }
        categoriesLabel.text = categories.joined(separator: " • ")
    }
}
