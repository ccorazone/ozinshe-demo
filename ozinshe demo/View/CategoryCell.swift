//
//  CategoryCell.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 01.04.2026.
//
import UIKit
import Localize_Swift
import SnapKit

class CategoryCell: UICollectionViewCell {
    
    static let id = "CategoryCell"
    
    private lazy var categoryLabel = UILabel.createLabel(font: UIFont(name: Fonts.semibold.rawValue, size: 12)!, color: .appgrey700, numberOfLines: 1)
    private lazy var cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .grey100
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpUI()
        setupConstraints()
        
    }
    
    private func setUpUI(){
        contentView.addSubview(cellView)
        cellView.addSubview(categoryLabel)
    }
    
    private func setupConstraints(){
        
        cellView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        categoryLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(category: String){
        categoryLabel.text = category
        
    }
}
