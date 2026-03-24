//
//  AuthorizationViewController.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 26.12.2025.
//

import UIKit
import SnapKit
import SVProgressHUD

class AuthorizationViewController: UIViewController {
    let viewModel = LoginViewModel()
    
    let titleLabel = UILabel.createLabel(text: "Сәлем", font: UIFont(name: Fonts.bold.rawValue, size: 24)!, color: Colors.Text.primary)
    let subTitleLabel = UILabel.createLabel(text: "Аккаунтқа кіріңіз", font: UIFont(name: Fonts.regular.rawValue, size: 16)!, color: Colors.Text.secondary)
    
    let loginTextField = AuthTextFieldView(title: "Email")
    let passwordTextField = CustomChangePasswordView(title: "Құпия сөз")
    lazy var loginButton: UIButton = {
        let btn = MainPurpleButton(title: "Кіру")
        btn.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return btn
    }()
    lazy var forgotPasswordButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Құпия сөзді ұмыттыңыз ба?"
        config.baseForegroundColor = Colors.Text.lightPurpleText
        var attributeString = AttributedString(config.title ?? "")
        attributeString.font = UIFont(name: Fonts.semibold.rawValue, size: 14)
        config.attributedTitle = attributeString
        config.titleAlignment = .trailing
        let btn = UIButton(configuration: config)
        btn.contentHorizontalAlignment = .trailing
        return btn
    }()
    
    lazy var registerButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var container = AttributeContainer()
        container.foregroundColor = Colors.Text.secondary
        container.font = UIFont(name: Fonts.semibold.rawValue, size: 14)
        var atributedTitle = AttributedString("Аккаунтыныз жоқ па? ", attributes: container)
        var purpleContainer = container
        purpleContainer.foregroundColor = Colors.Text.lightPurpleText
        var purpleTitle = AttributedString("Тіркелу", attributes: purpleContainer)
        atributedTitle.append(purpleTitle)
        config.attributedTitle = atributedTitle
        let btn = UIButton(configuration: config)
        btn.addAction(UIAction{ [weak self] _ in
            print("Register button tapped")
            let vc = RegisterViewController()
            self?.navigationController?.show(vc, sender: self)
            
        }, for: .touchUpInside)
       
        return btn
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //view.backgroundColor = .white
        view.backgroundColor = .primaryBackground
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(forgotPasswordButton)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        setupConstrints()
        bindViewModel()
        
        
    }
    
    func setupConstrints(){
        titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.left.right.equalToSuperview().inset(24)
        }
        subTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(0)
            make.left.right.equalToSuperview().inset(24)
        }
        
        loginTextField.snp.makeConstraints{ make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(24)
        }
        
        passwordTextField.snp.makeConstraints{ make in
            make.top.equalTo(loginTextField.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(24)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(24)
        }
        loginButton.snp.makeConstraints{ make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(24)
        }
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(24)
            
        }
        
        
    }
    
//    func validateEmail(){
//        guard let email = loginTextField.textField.text else { return }
//        
//        if email.isEmpty {
//            loginTextField.setError(message: "Қате формат")
//            
//        }else if !email.contains("@") {
//            loginTextField.setError(message: "mail")
//        }else{
//            loginTextField.setError(message: nil)
//        }
//    }
    
    @objc func loginTapped(){
        viewModel.login(username: loginTextField.textField.text, password: passwordTextField.passwordTextField.text)
        print("login tapped")
        
        //validateEmail()
    }
    
    private func bindViewModel(){
        viewModel.isLoading = { [weak self] isLoading in
            
            if isLoading{
                SVProgressHUD.show()
                SVProgressHUD.setDefaultMaskType(.clear)
            }else{
                SVProgressHUD.dismiss()
            }
        }
        viewModel.onError = { [weak self] error in
            guard let error = error else{
                self?.loginTextField.setError(message: nil)
                return
            }
            SVProgressHUD.showError(withStatus: error)

            self?.loginTextField.setError(message: error)
        }
        viewModel.onSuccess = { [weak self] in
            //let vc = TabBarViewController()
            //self?.navigationController?.pushViewController(vc, animated: true)
            //SVProgressHUD.dismiss()
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            
            if let sceneDelegate = self?.view.window?.windowScene?.delegate as? SceneDelegate {
                let vc = TabBarViewController()
                sceneDelegate.setRootVC( vc)
            }

        }
       
    }
}

