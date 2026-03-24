//
//  OnboardingVC.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 24.01.2026.
//
import UIKit
import SnapKit

class OnboardingVC: UIViewController {
    
    private lazy var titleLabel = UILabel.createLabel(text: "ÖZINŞE-ге қош келдің!" ,font: UIFont(name: Fonts.bold.rawValue, size: 24)!, color: Colors.Text.primary, textAlignment: .center)
    private lazy var subtitleLabel = UILabel.createLabel(font: UIFont(name: Fonts.medium.rawValue, size: 14)!, color: .appOnboardingSubtitle, textAlignment: .center)
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    private lazy var skipButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var atributes = AttributedString("Өткізу")
        atributes.font = UIFont(name: Fonts.medium.rawValue, size: 12)
        atributes.foregroundColor = Colors.Text.defaultBlack
        config.attributedTitle = atributes
        config.background.backgroundColor = Colors.View.profileViewColor
        config.background.cornerRadius = 8
        let btn = UIButton(configuration: config)
        let action = UIAction { [weak self] _ in
            self?.onSkip()
        }
        
        btn.addAction(action, for: .touchUpInside)
        
        return btn
    }()
    var onSkip: () -> Void = { }

    
    private lazy var nextButton: UIButton = {
        let btn = MainPurpleButton(title: "Әрі қарай")
        let action = UIAction { [weak self] _ in
            let vc = AuthorizationViewController()
            self?.navigationController?.show(vc, sender: self)
            print("NextButton is tapped")
            
        }
        btn.addAction(action, for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI(){
        view.addSubview(imageView)
        view.addSubview(skipButton)

        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(nextButton)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        skipButton.snp.makeConstraints{make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(24)
            make.width.equalTo(70)
        }
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(38)
        }
        subtitleLabel.snp.makeConstraints{make in
            make.bottom.equalTo(nextButton.snp.top).offset(-114)
            make.left.right.equalToSuperview().inset(32)
        }
        titleLabel.snp.makeConstraints{make in
            make.bottom.equalTo(subtitleLabel.snp.top).offset(-24)
            make.left.right.equalToSuperview().inset(32)
        }
        
        
    }
    
    func configure(model: OnboardingModel){
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        imageView.image = UIImage(named: model.image)
        skipButton.isHidden = model.isLast
        nextButton.isHidden = !model.isLast
    }
}
