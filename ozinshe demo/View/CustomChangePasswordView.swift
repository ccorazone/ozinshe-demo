//
//  CustomChangePasswordView.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 18.12.2025.
//
import UIKit
import SnapKit

class CustomChangePasswordView: UIView {
    
    private lazy var titleLabel = UILabel.createLabel(font: UIFont(name: Fonts.bold.rawValue, size: 14)!, color: Colors.Text.primary)
    //lazy var placeholderLabel = UILabel.createLabel(text: "Сіздің құпия сөзіңіз",font: UIFont(name: Fonts.regular.rawValue, size: 16)!, color: Colors.Text.secondary)
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        let atributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: Fonts.regular.rawValue, size: 16)!,
            .foregroundColor: Colors.Text.secondary
            ]
        textField.attributedPlaceholder = NSAttributedString(string: "Сіздің құпия сөзіңіз", attributes: atributes)
        textField.isSecureTextEntry = true
        textField.backgroundColor = .apptextField
        
        return textField
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        //view.backgroundColor = .clear
        view.backgroundColor = .apptextField
        view.layer.borderWidth = 1
        view.layer.borderColor = Colors.View.borderColorGray.cgColor
        return view
    }()
    
    private lazy var  keyImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "key")
        return image
    }()
    
    private lazy var showButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "show"), for: .normal)
       // button.backgroundColor = .clear
        button.backgroundColor = .primaryBackground
        button.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        
        return button
    }()
    
    
    
    
    init(title: String) {
        
        super.init(frame: .zero)
        passwordTextField.delegate = self
        titleLabel.text = title
        setupView()
        setupConstraints()
        
    }
    
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView(){
        addSubview(titleLabel)
        addSubview(containerView)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(keyImageView)
        containerView.addSubview(showButton)
        
        
    }
    
    
    private func setupConstraints(){
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        containerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.height.equalTo(56)
            
        }
        keyImageView.snp.makeConstraints { (make) in
            //make.top.bottom.equalTo(ContainerView).inset(18)
            make.left.equalTo(containerView).offset(16)
            make.centerY.equalTo(containerView.snp.centerY)
            make.size.equalTo(20)
            
        }
        passwordTextField.snp.makeConstraints { (make) in
            make.left.equalTo(keyImageView.snp.right).offset(8)
            make.top.bottom.equalTo(containerView).inset(18)
        }
        showButton.snp.makeConstraints{ make in
            make.left.equalTo(passwordTextField.snp.right).offset(8)
            make.right.equalTo(containerView).inset(16)
            make.centerY.equalTo(containerView)
            make.size.equalTo(20)
        }
    }
    
    
    @objc func showPassword(_ sender: UIButton) {
        print("showPassword")
        sender.isSelected.toggle()
        
        passwordTextField.isSecureTextEntry = !sender.isSelected
    }
}

extension CustomChangePasswordView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2){
            self.containerView.layer.borderColor = Colors.Text.purpleFont.cgColor
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2){
            self.containerView.layer.borderColor = Colors.View.borderColorGray.cgColor
        }
    }
}



