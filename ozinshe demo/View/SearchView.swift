//
//  SearchView.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 31.03.2026.
//
import UIKit
import Localize_Swift
import SnapKit

class SearchView: UIView{
    
    var onSearchTextChanged: ((String) -> ())?
    
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: Fonts.semibold.rawValue, size: 16),
            .foregroundColor: Colors.Text.secondary
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "search_title".localized(), attributes: attributes)
        textField.backgroundColor = .clear
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Colors.View.borderColorGray.cgColor
        textField.autocapitalizationType = .none
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 56))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.rightView = clearButton
        textField.rightViewMode = .never
        
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var clearButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "Cross")
        config.baseBackgroundColor = .clear
        config.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 8, bottom: 18, trailing: 16)
        let btn = UIButton(configuration: config)
        btn.addAction(UIAction{[weak self] _ in
            self?.searchTextField.text = ""
            self?.searchTextField.rightViewMode = .never
            self?.onSearchTextChanged?("")
        }, for: .touchUpInside)
        return btn
        
        
    }()
    
    lazy var searchButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(named: "SearchButton")
        config.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 18, bottom: 18, trailing: 18)
        config.background.cornerRadius = 12
        config.baseForegroundColor = .appgrey700
        config.baseBackgroundColor = .grey100
        let btn = UIButton(configuration: config)
        let action = UIAction {[weak self] _ in
            
        }
        btn.addAction(action, for: .touchUpInside)
        return btn
    }()
    
    lazy var titleLabel = UILabel.createLabel(text: "category_title".localized(), font: UIFont(name: Fonts.bold.rawValue, size: 24)!, color: Colors.Text.primary)
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.id)
        return collectionView
    }()
    
    let moviesTableView = MoviesListView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .primaryBackground
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.addSubview(searchTextField)
        self.addSubview(searchButton)
        self.addSubview(titleLabel)
        self.addSubview(collectionView)
        self.addSubview(moviesTableView)
        moviesTableView.isHidden = true
    }
    
    private func setupConstraints(){
        searchTextField.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalTo(searchButton.snp.leading).offset(-16)
            make.height.equalTo(56)
        }
        
        searchButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(searchTextField)
            make.trailing.equalToSuperview().inset(24)
            make.width.height.equalTo(56)
        }
        
        titleLabel.snp.makeConstraints{make in
            make.top.equalTo(searchTextField.snp.bottom).offset(35)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        moviesTableView.snp.makeConstraints{make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func updateLocalization(){
        let atributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: Fonts.semibold.rawValue, size: 16)!,
            .foregroundColor: Colors.Text.secondary
        ]
        searchTextField.attributedPlaceholder = NSAttributedString(string: "search_title".localized(), attributes: atributes)
        titleLabel.text = "category_title".localized()
        collectionView.reloadData()
    }
    
    func setTextFieldActive(_ isActive: Bool){
        
        UIView.animate(withDuration: 0.2){
            self.searchTextField.layer.borderColor = isActive ? Colors.Text.purpleFont.cgColor : Colors.View.borderColorGray.cgColor
            let color = isActive ? Colors.Text.purpleFont : .appgrey700
            
            if var config = self.searchButton.configuration {
                config.baseForegroundColor = color
                self.searchButton.configuration = config
            }
            
            
            
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField){
        let text = textField.text ?? ""
        searchTextField.rightViewMode = text.isEmpty ? .never : .always
        onSearchTextChanged?(text)
    }
}


