//
//  PosterAndTitleCell.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 10.04.2026.
//
import UIKit
import SnapKit
import SDWebImage

class PosterAndTitleCell: UICollectionViewCell{
    static let reuseId = "PosterAndTitleCell"
    
    private lazy var posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        return iv
    }()
    private lazy var titleLabel = UILabel.createLabel(font: UIFont(name: Fonts.semibold.rawValue, size: 14)!, color: .white, textAlignment: .center)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setConstraints()
    }
    private func setupUI(){
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
    }
    
    private func setConstraints(){
        posterImageView.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
        titleLabel.snp.makeConstraints{ make in
            make.center.equalTo(posterImageView)
            make.leading.trailing.equalTo(posterImageView).inset(16)
        }
    }
    
    func setData(data: Card){
        let link = data.link.replacingOccurrences(of: "api.ozinshe.com", with: "apiozinshe.mobydev.kz")
        posterImageView.sd_setImage(with: URL(string: link))
        titleLabel.text = data.name
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
