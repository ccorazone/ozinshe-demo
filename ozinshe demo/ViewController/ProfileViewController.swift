//
//  ProfileViewController.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 12.12.2025.
//
import UIKit
import SnapKit
class ProfileViewController: UIViewController {
   
    let viewModel = UserProfileViewModel()
    
   
    lazy var navigationTitle = UILabel.createLabel(text: "Профиль",font: UIFont(name: Fonts.bold.rawValue, size: 16)!, color: Colors.Text.primary,textAlignment: .center)
    
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 60
        imageView.image = UIImage(named: "avatar")
        return imageView
    }()
    
    
    lazy var titleLabel =   UILabel.createLabel(text: "Менің профилім", font: UIFont(name: Fonts.bold.rawValue, size: 24)!, color: Colors.Text.primary, textAlignment: .center)
    lazy var emailLabel =  UILabel.createLabel(text: "madi", font: UIFont(name: Fonts.regular.rawValue, size: 14)!, color: Colors.Text.secondary, textAlignment: .center)
    
    lazy var profileSubView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.View.profileViewColor
        return view
    }()
    
    lazy var infoButton: SettingsButton = {
        let button = SettingsButton(title: "Жеке деректер", subtitle: "Өңдеу", showChevron: true)
        button.addTarget(self, action: #selector(didTapInfoButton), for: .touchUpInside)
        return button
    }()
    
    lazy var passwordButton: SettingsButton = {
        let button = SettingsButton(title: "Құпия сөзді өзгерту", subtitle: nil, showChevron: true)
        button.addTarget(self, action: #selector(didTapPasswordButton), for: .touchUpInside)
        return button
    }()
    
    lazy var languageButton: SettingsButton = {
        let button = SettingsButton(title: "Тіл", subtitle: "Қазақша", showChevron: true)
        button.addTarget(self, action: #selector(didTapLanguageButton), for: .touchUpInside)
        return button
    }()
    
    lazy var lightmodeButton: SettingsButton = {
        let button = SettingsButton(title: "Қараңғы режим", subtitle: nil, isSwitch: true)
        button.addTarget(self, action: #selector(didTapLightmodeButton), for: .valueChanged)
        return button
    }()
    
    
    
    lazy var settingsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.backgroundColor = Colors.View.profileViewColor
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        let buttons = [infoButton, passwordButton, languageButton, lightmodeButton]
        buttons.forEach { button in
            stackView.addArrangedSubview(button)
            if button != buttons.last {
                let separatorView = SeparatorView()
                stackView.addArrangedSubview(separatorView)
                
                
            }
        }
        return stackView
    }()
    
    lazy var namesStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, emailLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    lazy var contentStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [avatarImageView, namesStackView, settingsStackView])
        stack.axis = .vertical
        stack.spacing = 24
        stack.alignment = .center
        return stack
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    var languages: [Languages] = [Languages(name: "English", code: "en", isSelected: false),
                                  Languages(name: "Қазақша", code: "kz", isSelected: true),
                                  Languages(name: "Русский", code: "ru", isSelected: false)
    ]
    
    
   
    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        //view.backgroundColor = .white
        view.backgroundColor = .primaryBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
        setupConstraints()
        //navigationController?.navigationBar.tintColor = .red
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "logout" ), style: .plain, target: self, action: #selector(didLogout))
        navigationItem.titleView = navigationTitle
        bindingVM()
        viewModel.fetchProfile()
        
        
        
        
    }
    
    
    
    
//    func createView(color: UIColor) -> UIView {
//        let view = UIView()
//        view.backgroundColor = color
//        return view
//    }
    
    private func setupConstraints(){
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(24)
        }
        
        
        avatarImageView.snp.makeConstraints { make in
           // make.top.equalToSuperview().offset(24)
            //make.left.equalToSuperview().offset(24)
            make.size.equalTo(120)
        }
        
        settingsStackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        
       
        
        
        
    }
    
    @objc func didTapInfoButton(){
        print("tapped 1")
        let vc = EditProfileViewController()
        vc.viewModel = self.viewModel
        navigationController?.show(vc, sender: self)
    }
    
    @objc func didTapPasswordButton(){
        print("tapped 2")
        let vc = ChangePasswordViewController()
        navigationController?.show(vc, sender: self)

    }
    
    @objc func didTapLanguageButton(){
        print("tapped 3")
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        
        tableView.register(LanguagesCell.self, forCellReuseIdentifier: "LanguageCell")
        tableView.snp.makeConstraints { make in
            make.height.equalTo(172)
        }
        
        let vc = BottomSheetViewController(title: "Тіл", mainContent: tableView, padding: 12)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    @objc func didTapLightmodeButton(){
        print("tapped 4")
    }
    
    @objc func didLogout(){
        print("tapped 5")
        let exitView = LogoutSheetView()
        let vc = BottomSheetViewController(title: "Шығу", mainContent: exitView, padding: 8)
        
        exitView.onCancelTapped = {[weak self] in
            self?.dismiss(animated: true)
        }
        
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    
    private func bindingVM(){
        viewModel.didUpdateProfile = {[weak self] in
            guard let self = self, let user = self.viewModel.userProfile else {return }
            self.emailLabel.text = user.user.email
            //self.languageButton.setSubtitle(text: user.language ?? "Қазақша")
            self.setLanguages()
        }
    }
    
    private func setLanguages(){
        let currentLanguage = viewModel.userProfile?.language ?? "kz"
        for i in 0..<languages.count{
            languages[i].isSelected = (currentLanguage == languages[i].code)
            
            if languages[i].isSelected{
                languageButton.setSubtitle(text: languages[i].name)
            }
        }
    }
    
    

    
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguagesCell
        let isLast = indexPath.row == languages.count - 1
        cell.configure(languages[indexPath.row], isLast: isLast)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0..<languages.count {
            languages[i].isSelected = false
        }
        languages[indexPath.row].isSelected = true
        let selectedLanguage = languages[indexPath.row]
        viewModel.userProfile?.language = selectedLanguage.code
        languageButton.setSubtitle(text: languages[indexPath.row].name)
        //UserDefaults.standard.set(languages[indexPath.row].name, forKey: "language")
        tableView.reloadData()
        dismiss(animated: true)
        
    }
    
}
