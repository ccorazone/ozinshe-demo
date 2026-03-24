//
//  ChangePasswordViewController.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 18.12.2025.
//
import UIKit
import SnapKit

class ChangePasswordViewController: UIViewController {
    let viewModel = ChangePasswordViewModel()
    lazy var firstPasswordView = CustomChangePasswordView(title: "Password")
    lazy var secondPasswordView = CustomChangePasswordView(title: "Құпия сөзді қайталаңыз")
    lazy var changePasswordButton = {
        let btn = MainPurpleButton(title: "Өзгерістерді сақтау")
        let action = UIAction{[weak self] _ in
            self?.saveNewPassword()
        }
        btn.addAction(action, for: .touchUpInside)
        return btn
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstPasswordView, secondPasswordView])
        stack.axis = .vertical
        stack.spacing = 24
        stack.distribution = .fill
        return stack
    }()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //view.backgroundColor = .white
        view.backgroundColor = .primaryBackground
        
        setupView()
        bindingVM()
        
    }
    
    private func setupView(){
        view.addSubview(stackView)
        view.addSubview(changePasswordButton)
        stackView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide).inset(24)
            
        }
        
        changePasswordButton.snp.makeConstraints{ make in
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        
    }
    private func saveNewPassword(){
        guard let firstPassword = firstPasswordView.passwordTextField.text, !firstPassword.isEmpty,
              let secondPassword = secondPasswordView.passwordTextField.text, !secondPassword.isEmpty else {
            return
        }
        if firstPassword != secondPassword {
            
            showAlert(title: "Ошибка", message: "Пароли не совпадают")
            return
        }else if firstPassword.count < 4{
            showAlert(title: "Қате", message: "Длина пароля должна быть не менее 4 символов")
        }else{
            viewModel.updatePassword(password: firstPassword)

        }
    }
    
    private func bindingVM(){
        viewModel.didUpdated = { [weak self] in
            self?.showAlert(title: "Успешно", message: "Пароль был изменен!"){
                self?.navigationController?.popViewController(animated: true)
            }
        }
        
        viewModel.onError = {[weak self] error in
            self?.showAlert(title: "Қате", message: error)
        }
        
    }
    //"Қате"
    private func showAlert(title: String, message: String, action: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default){_ in
            action?()
        })
        present(alert, animated: true)
    }
    
    
    
}
