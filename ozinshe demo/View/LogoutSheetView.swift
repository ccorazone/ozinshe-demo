//
//  LogoutSheetView.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 19.12.2025.
//
import UIKit
import SnapKit

class LogoutSheetView: UIView {
    
    var onCancelTapped: (() -> Void)?
    
    lazy  var titleLabel = UILabel.createLabel(text: "Сіз шынымен аккаунтыныздан", font: UIFont(name: Fonts.regular.rawValue, size: 16)!, color: Colors.Text.secondary)
    
    lazy var exitButton: MainPurpleButton = {
        let btn = MainPurpleButton(title: "Иә, шығу")
        btn.addTarget(self, action: #selector (exitTapped), for: .touchUpInside)
        return btn
    }()
    
    lazy var cancelButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(Colors.Text.purpleText, for: .normal)
        btn.setTitle("Жоқ", for: .normal)
        btn.titleLabel?.font = UIFont(name: Fonts.semibold.rawValue, size: 16)!
        btn.addTarget(self, action: #selector (cancelTapped), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var btnStackView : UIStackView = {
        let stack = UIStackView(arrangedSubviews: [exitButton, cancelButton])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, btnStackView])
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .fill
        stack.alignment = .fill
        return stack
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(){
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            
        }
        cancelButton.snp.makeConstraints { (make) in
            make.height.equalTo(56)
        }
    }
    @objc func exitTapped(){
        print("exitTapped")
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        if let sceneDelegate = window?.windowScene?.delegate as? SceneDelegate {
            let vc = OnboardingPageController()
            sceneDelegate.setRootVC( vc, isNavigation: true)
        }
        
    }
    
    @objc func cancelTapped(){
        print("cancel")
        onCancelTapped?()
    }
        
}

    
    
