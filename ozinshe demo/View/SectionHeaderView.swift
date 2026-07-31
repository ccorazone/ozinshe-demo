//
//  WatchHistoryHeaderView.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 08.04.2026.
//

import UIKit
import SnapKit

class SectionHeaderView: UICollectionReusableView{
    static let reuseId = "SectionHeaderView"
    private let titleLabel = UILabel.createLabel(font: UIFont(name: Fonts.bold.rawValue, size: 16)!, color: Colors.Text.primary,
                                                                                         numberOfLines: 2)
    private let allTextLabel = UILabel.createLabel(text: "all_title".localized(), font: UIFont(name: Fonts.semibold.rawValue, size: 14)!, color: Colors.Text.purpleText,
                                                   textAlignment: .right, numberOfLines: 1)
    var onViewPressed: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(allTextLabel)
        setupGesture()
        allTextLabel.isHidden = false
        allTextLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        titleLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.trailing.lessThanOrEqualTo(allTextLabel.snp.leading).offset(-16)
        }
        allTextLabel.snp.makeConstraints{make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func setupGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
    }
    
    @objc private func handleTap(){
        onViewPressed?()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(_ title: String, showAllLabel: Bool = false){
        titleLabel.text = title
        allTextLabel.isHidden = !showAllLabel
    }
}
