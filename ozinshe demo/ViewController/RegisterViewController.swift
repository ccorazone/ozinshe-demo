//
//  RegisterViewController.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 23.01.2026.
//
import UIKit
import SnapKit

class RegisterViewController: UIViewController {
    private let viewModel = AuthViewModel()
    
    private let titleLabel = UILabel.createLabel(text: "Тіркелу", font: UIFont(name: Fonts.bold.rawValue, size: 24)!, color: Colors.Text.primary)
    private let subTitleLabel = UILabel.createLabel(text: "Деректерді толтырыңыз", font: UIFont(name: Fonts.regular.rawValue, size: 16)!, color: Colors.Text.secondary)
    
    private let loginTextField = AuthTextFieldView(title: "Email")
    private let passwordTextField = CustomChangePasswordView(title: "Құпия сөз")
    private let confirmPasswordTextField = CustomChangePasswordView(title: "Құпия сөзді қайталаңыз")
    
    private lazy var registerButton: UIButton = {
        let btn = MainPurpleButton(title: "Тіркелу")
        let action = UIAction { [weak self] _ in
            self?.checkInfo()
            
        }
        btn.addAction(action, for: .touchUpInside)
        return btn
    }()
    
    private lazy var loginButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var container = AttributeContainer()
        container.foregroundColor = Colors.Text.secondary
        container.font = UIFont(name: Fonts.semibold.rawValue, size: 14)
        var atributedTitle = AttributedString("Сізде аккаунт бар ма? ", attributes: container)
        var purpleContainer = container
        purpleContainer.foregroundColor = Colors.Text.lightPurpleText
        var purpleTitle = AttributedString("Тіркелу", attributes: purpleContainer)
        atributedTitle.append(purpleTitle)
        config.attributedTitle = atributedTitle
        let btn = UIButton(configuration: config)
        let action = UIAction { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        btn.addAction(action, for: .touchUpInside)
       
        return btn
    }()
    private lazy var tfStackView: UIStackView = {
        let sv = UIStackView()
        let tf = [loginTextField, passwordTextField, confirmPasswordTextField, errorLabel]
        tf.forEach{
            sv.addArrangedSubview($0)
        }
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        sv.spacing = 16
        return sv
    }()
    private lazy var errorLabel: UILabel = {
        let label = UILabel.createLabel(text: "Мұндай email-ы бар пайдаланушы тіркелген",
                                                          font: UIFont(name: Fonts.regular.rawValue, size: 14)!,
                                        color: Colors.View.borderRedColor, textAlignment: .center)
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .white
        view.backgroundColor = .primaryBackground
        setupUI()
        bindViewModel()
        
    }
    private func checkInfo(){
        
        errorLabel.isHidden = true
        viewModel.register(email: loginTextField.textField.text, password: passwordTextField.passwordTextField.text, confirmPassword: confirmPasswordTextField.passwordTextField.text)
        
    }
    private func bindViewModel(){
        viewModel.onSuccess = { [weak self] in
            print("success")
        }
        
        viewModel.onError = { [weak self] error in
            self?.errorLabel.text = error
            self?.errorLabel.isHidden = false
            
        }
    }
    
    private func setupUI(){
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
//        view.addSubview(loginTextField)
//        view.addSubview(passwordTextField)
//        view.addSubview(confirmPasswordTextField)
        view.addSubview(tfStackView)
        view.addSubview(registerButton)
        view.addSubview(loginButton)
        
        tfStackView.setCustomSpacing(32, after: confirmPasswordTextField)
        
        titleLabel.snp.makeConstraints{make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.right.equalToSuperview().inset(24)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(0)
            make.left.right.equalToSuperview().inset(24)
        }
        tfStackView.snp.makeConstraints{make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(24)
        }
        registerButton.snp.makeConstraints{make in
            make.top.equalTo(tfStackView.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(24)
        }
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(registerButton.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(24)

        }
        
    }
}
