//
//  EditProfileViewController.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 18.12.2025.
//
import UIKit
import SnapKit

class EditProfileViewController: UIViewController {
    var viewModel: UserProfileViewModel!
    
    lazy var nameField = CustomProfileInfoView(title: "Сіздің атыңыз", value: "Мади")
    lazy var emailField = CustomProfileInfoView(title: "Email", value: "madi.temeshev@mail.ru", isEnabled: false)
    lazy var phoneField = CustomProfileInfoView(title: "Телефон", value: "+7 708 639-53-01")
    lazy var birthdayField = CustomProfileInfoView(title: "Туылған күні", value: "19 Қыркүйек 2004")
    
//    lazy var navigationTitle: UILabel = {
//       let label = UILabel()
//        label.text = "Жеке деректер"
//        label.font = UIFont(name: Fonts.bold.rawValue, size: 16)!
//        label.textColor = Colors.Text.primary
//        return label
//    }()
    lazy var navigationTitle = UILabel.createLabel(text: "Жеке деректер", font: .systemFont(ofSize: 16, weight: .bold), color: Colors.Text.primary, textAlignment: .center)
    
    
    lazy var saveButton: MainPurpleButton = {
        let button = MainPurpleButton(title: "Өзгерістерді сақтау")
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameField, emailField, phoneField, birthdayField])
        stack.axis = .vertical
        stack.spacing = 24
        stack.distribution = .fill
        return stack
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        return sv
        
    }()
    
    lazy var scrollContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .white
        view.backgroundColor = .primaryBackground
        
        navigationItem.title = "Жеке деректер"
        setConstraints()
        navigationItem.titleView = navigationTitle
        updateUI()
        
    }
    
    func setConstraints(){
        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(stackView)
        view.addSubview(saveButton)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(saveButton.snp.top).inset(16)
        }
        scrollContentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(24)
            
        }
        saveButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.height.equalTo(56)
        }
    }
    
    @objc func saveButtonTapped(){
        print("saved")
        saveButton.isEnabled = false
        let currentLanguage = viewModel.userProfile?.language ?? "kz"
        viewModel.updateProfile(birthDate: birthdayField.valueTextField.text ?? "-",
                                id: viewModel.userProfile?.user.id ?? 0,
                                language: currentLanguage,
                                name: nameField.valueTextField.text ?? "-",
                                phoneNumber: phoneField.valueTextField.text ?? "-"){[weak self] isUpdate in
            guard let self = self else { return }
            self.saveButton.isEnabled = true
            if isUpdate{
                print("updated")
                let alert = UIAlertController(title: "Успешно", message: "Данные сохранены", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default){_ in
                    self.navigationController?.popViewController(animated: true)
                })
                self.present(alert, animated: true)
                self.updateUI()
            }else{
                let alert = UIAlertController(title: "Қате", message: "Деректерді сақтау мүмкін болмады", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
        }
    }
    
    private func updateUI(){
        guard let user = viewModel.userProfile else { return }
        self.nameField.valueTextField.text = user.name
        self.emailField.valueTextField.text = user.user.email
        self.phoneField.valueTextField.text = user.phoneNumber ?? "-"
        self.birthdayField.valueTextField.text = user.birthDate ?? "-"
        
        
    }
}
