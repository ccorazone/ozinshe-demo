//
//  SettingsButton.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 17.12.2025.
//
import UIKit
import SnapKit

class SettingsButton: UIButton {
    
    private lazy var buttonTitleLabel =  UILabel.createLabel(font: UIFont(name: Fonts.bold.rawValue, size: 16)!, color: Colors.Text.primary)
    private lazy var buttonSubtitleLabel = UILabel.createLabel(font: UIFont(name: Fonts.regular.rawValue, size: 12)!, color: Colors.Text.secondary)
    
    private lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Chevron")
        imageView.contentMode = .scaleAspectFit
        //imageView.backgroundColor = .clear
        imageView.backgroundColor = .primaryBackground
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var switchView: UISwitch = {
        let switchView = UISwitch()
        switchView.isHidden = true
        switchView.addTarget(self, action: #selector(switchToggle), for: .valueChanged)
        switchView.onTintColor = .appLightPurpleText
        return switchView
    }()
    
    
    
    init(title: String, subtitle: String?, isSwitch: Bool = false, showChevron: Bool = false) {
        super.init(frame: .zero)
        setupIntetface()
        buttonTitleLabel.text = title
        buttonTitleLabel.isHidden = false
        if let subtitle = subtitle {
            buttonSubtitleLabel.text = subtitle
            buttonSubtitleLabel.isHidden = false
        }
        else{
            buttonSubtitleLabel.isHidden = true
        }
        
        chevronImageView.isHidden = !showChevron
        switchView.isHidden = !isSwitch
        isUserInteractionEnabled = true
    
        
    }
    
    
    
    private func setupIntetface(){
        let rightStackView = UIStackView(arrangedSubviews: [buttonSubtitleLabel, chevronImageView])
        let spacer = UIView()
        rightStackView.axis = .horizontal
        rightStackView.spacing = 8
        rightStackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        let mainStackView = UIStackView(arrangedSubviews: [buttonTitleLabel,spacer, rightStackView])
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        addSubview(mainStackView)
        addSubview(switchView)
        mainStackView.isUserInteractionEnabled = false
        buttonTitleLabel.isUserInteractionEnabled = false
        buttonSubtitleLabel.isUserInteractionEnabled = false
        chevronImageView.isUserInteractionEnabled = false

        
        mainStackView.snp.makeConstraints{ make in

            make.edges.equalToSuperview()
                
        }
        switchView.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(0)
        }
        
        
        
    }
    
    func setSubtitle(text: String?){
        buttonSubtitleLabel.text = text
    }
    
    @objc private func switchToggle(_ sender: UISwitch){
        print(sender.isOn)
        UserDefaults.standard.set(sender.isOn, forKey: "ThemeOfApp")
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first{
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.overrideUserInterfaceStyle = sender.isOn ? .dark : .light
            }, completion: nil)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
}


