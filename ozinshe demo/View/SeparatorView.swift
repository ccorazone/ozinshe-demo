//
//  SeparatorView.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 15.12.2025.
//
import UIKit

class SeparatorView: UIView {
    private var height: CGFloat
    
    
    init(height: CGFloat = 1) {
        self.height = height
        super.init(frame: .zero)
        self.backgroundColor = Colors.View.viewLigtGray
        setupConstraints()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints(){
        snp.makeConstraints { make in
            make.height.equalTo(height)
            
        }
    }
}







