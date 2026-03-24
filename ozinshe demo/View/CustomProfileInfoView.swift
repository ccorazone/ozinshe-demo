//
//  CustomProgileInfoView.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 18.12.2025.
//

import UIKit
import SnapKit

class CustomProfileInfoView: UIView {

    private lazy var titleLabel = UILabel.createLabel(font: UIFont(name: Fonts.bold.rawValue, size: 14)!, color: Colors.Text.secondary)
    

    //lazy var valueTextField = UILabel.createLabel(font: UIFont(name: Fonts.medium.rawValue, size: 16)!, color: Colors.Text.primary)
    lazy var valueTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = Colors.Text.primary
        tf.textAlignment = .left
        tf.font = UIFont(name: Fonts.medium.rawValue, size: 16)!
        return tf
    }()
    
    private lazy var separatorView: SeparatorView = SeparatorView()
    
    init(title: String, value: String, isEnabled: Bool = true) {
        super.init(frame: .zero)
        setupView(title: title, value: value)
        if !isEnabled {
            valueTextField.isEnabled = false
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView(title: String, value: String){
        titleLabel.text = title
        valueTextField.text = value
        addSubview(titleLabel)
        addSubview(valueTextField)
        addSubview(separatorView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        valueTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            
        }
        separatorView.snp.makeConstraints {make in
            make.top.equalTo(valueTextField.snp.bottom).offset(12)
        
            make.left.right.bottom.equalToSuperview()
            
        }
        
        
    }
    
}
