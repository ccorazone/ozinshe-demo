//
//  MainPurpleButton.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 18.12.2025.

import UIKit
import SnapKit

class MainPurpleButton: UIButton {
    
    
    init(title: String) {
        super.init(frame: .zero)
        setup(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(title: String) {
        setTitle(title, for: .normal)
        backgroundColor = .systemPurple
        setTitleColor(.white, for: .normal)
        backgroundColor = Colors.Button.purpleButton
        layer.cornerRadius = 12
        titleLabel?.font = UIFont(name: Fonts.semibold.rawValue, size: 16)!
        
        snp.makeConstraints { make in
            make.height.equalTo(56)
        }
    }
}

