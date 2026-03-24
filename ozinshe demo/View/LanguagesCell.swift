//
//  LanguagesCell.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 19.12.2025.
//
import UIKit
import SnapKit

class LanguagesCell: UITableViewCell {
    lazy var nameLabel = UILabel.createLabel(font: UIFont(name: Fonts.semibold.rawValue, size: 16)!, color: Colors.Text.primary)
    lazy var checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Check")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy var separatorView = SeparatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .primaryBackground
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(){
        contentView.addSubview(nameLabel)
        contentView.addSubview(checkImageView)
        contentView.addSubview(separatorView)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            
            make.left.equalToSuperview()
           
        }
        checkImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            
        }
        
        separatorView.snp.makeConstraints{make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            
        }
        
        
    }
    func configure(_ language: Languages, isLast: Bool){
        nameLabel.text = language.name
        checkImageView.isHidden = !language.isSelected
        separatorView.isHidden = isLast
    }
    
}
