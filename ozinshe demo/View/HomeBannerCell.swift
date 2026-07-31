//
//  HomeBannerCell.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 08.04.2026.
//

import UIKit
import SnapKit
import SDWebImage

class HomeBannerCell: UICollectionViewCell{
    static let reuseId = "HomeBannerCell"
    
    private lazy var posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        return iv
    }()
   
    private lazy var categoryLabel = UILabel.createLabel(font: UIFont(name: Fonts.regular.rawValue, size: 12)!,
                                        color: .white, textAlignment: .center)
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.Button.purpleButton
        view.layer.cornerRadius = 8
        return view
    }()
        
    
    private lazy var titleLabel = UILabel.createLabel(font: UIFont(name: Fonts.bold.rawValue, size: 14)!, color: Colors.Text.primary, numberOfLines: 1)
    private lazy var subTitleLabel = UILabel.createLabel(font: UIFont(name: Fonts.regular.rawValue, size: 12)!, color: Colors.Text.secondary, numberOfLines: 2)
    
    
    
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
        contentView.addSubview(containerView)
        containerView.addSubview(categoryLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
    }
    
    private func setConstraints(){
        posterImageView.snp.makeConstraints{make in
            make.top.leading.trailing.equalToSuperview()
            make.height.greaterThanOrEqualTo(164)
            
        }
        containerView.snp.makeConstraints{ make in
            make.leading.top.equalTo(posterImageView).offset(8)
        }
        categoryLabel.snp.makeConstraints{ make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.bottom.equalToSuperview().inset(4)
        }
        titleLabel.snp.makeConstraints{make in
            make.top.equalTo(posterImageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
        }
        subTitleLabel.snp.makeConstraints{make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setData(bannerMovie: BannerMovie){
        let link = bannerMovie.link
        let temp = link.replacingOccurrences(of: "api.ozinshe.com", with: "apiozinshe.mobydev.kz")
        posterImageView.sd_setImage(with: URL(string: temp))
        categoryLabel.text = bannerMovie.movie.categories?.first?.name ?? "--"
        titleLabel.text = bannerMovie.movie.name
        subTitleLabel.text = (bannerMovie.movie.description ?? "")
    }
}
