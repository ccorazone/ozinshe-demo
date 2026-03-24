//
//  AuthTextFieldView.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 27.12.2025.
//
import UIKit
import SnapKit

class AuthTextFieldView: UIView {
    private let titleLabel = UILabel.createLabel(font: UIFont(name: Fonts.bold.rawValue, size: 14)!, color: Colors.Text.primary)
    var errorLabel = UILabel.createLabel(text: "Қате формат", font: UIFont(name: Fonts.regular.rawValue, size: 14)!, color: Colors.View.borderRedColor)
    
    let textField: UITextField = {
        let textField = UITextField()
        let atributs: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: Fonts.regular.rawValue, size: 16)!,
            .foregroundColor: Colors.Text.secondary
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Сіздің email", attributes: atributs)
        textField.font = UIFont(name: Fonts.semibold.rawValue, size: 16)
        textField.textColor = Colors.Text.primary
        textField.backgroundColor = .apptextField
        textField.autocapitalizationType = .none
        return textField
    }()
      
    let containerView: UIView = {
        let view = UIView()
        //view.backgroundColor = .clear
        view.backgroundColor = .apptextField
        view.layer.borderWidth = 1
        view.layer.borderColor = Colors.View.borderColorGray.cgColor
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var leftIconView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Message")
       
        return iv
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    init(title: String){
        super.init(frame: .zero)
        titleLabel.text = title
        errorLabel.isHidden = true
        textField.delegate = self
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addSubviews(){
//        addSubview(titleLabel)
//        addSubview(containerView)
//        addSubview(errorLabel)
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(containerView)
        mainStackView.addArrangedSubview(errorLabel)
        mainStackView.setCustomSpacing(4, after: titleLabel)
        mainStackView.setCustomSpacing(16, after: containerView)
        containerView.addSubview(leftIconView)
        containerView.addSubview(textField)
    }
    
    func setError(message: String?){
        if let message = message{
            errorLabel.text = message
            errorLabel.isHidden = false
            
            errorLabel.textColor = Colors.View.borderRedColor
        }else{
            errorLabel.isHidden = true
        }
        UIView.animate(withDuration: 0.2) {
            self.updateBorderColor()
        }
    }
    private func updateBorderColor(){
        if !errorLabel.isHidden{
            containerView.layer.borderColor = Colors.View.borderRedColor.cgColor
            containerView.layer.borderWidth = 1
        }
        else if textField.isFirstResponder{
            containerView.layer.borderColor = Colors.Text.purpleFont.cgColor
            containerView.layer.borderWidth = 1
        }else{
            containerView.layer.borderColor = Colors.View.borderColorGray.cgColor
            containerView.layer.borderWidth = 1
        }
    }
    
    private func makeConstraints(){
        mainStackView.snp.makeConstraints{make in
            make.edges.equalToSuperview()
        }
        containerView.snp.makeConstraints{make in
            
            make.height.equalTo(56)
        }
        
        
        
        leftIconView.snp.makeConstraints{make in
            make.left.equalToSuperview().offset(16)
            make.top.bottom.equalToSuperview().inset(18)
            make.size.equalTo(20)
        }
        textField.snp.makeConstraints{make in
            make.left.equalTo(leftIconView.snp.right).offset(8)
            make.top.bottom.equalToSuperview().inset(16)
            make.right.equalToSuperview().inset(16)
        }
        
    }
}

extension AuthTextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2){
            self.updateBorderColor()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2){
            self.updateBorderColor()
        }
    }
}

