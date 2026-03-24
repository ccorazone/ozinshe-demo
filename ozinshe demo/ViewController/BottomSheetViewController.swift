//
//  BottomSheetViewController.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 19.12.2025.
//
import UIKit
import SnapKit

class BottomSheetViewController: UIViewController {
    
    lazy var titleLabel = UILabel.createLabel(font: UIFont(name: Fonts.bold.rawValue, size: 24)!, color: Colors.Text.primary)
    
    lazy var contentView: UIView = {
        let view = UIView()
        //view.backgroundColor = .white
        view.backgroundColor = .primaryBackground
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    lazy var separatorView = SeparatorView(height: 5)
    
    private let mainContent: UIView
    private let padding: CGFloat
    
   
    
    init(title: String, mainContent: UIView,padding: CGFloat){
        //self.height = height
        self.mainContent = mainContent
        self.padding = padding
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = title

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        //view.backgroundColor = .primaryBackground
        setupConstraints()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
     }
    
    
    func setupConstraints(){
        view.addSubview(contentView)
        contentView.addSubview(separatorView)
        contentView.addSubview(titleLabel)
        
        contentView.addSubview(mainContent)
        contentView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            //make.height.equalTo(height)
        }
        
        separatorView.snp.makeConstraints{ make in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(64)
        }
        titleLabel.snp.makeConstraints{ make in
            make.left.right.equalTo(contentView).inset(24)
            make.top.equalTo(separatorView.snp.bottom).offset(32)
        }
        
        mainContent.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(padding)
            make.left.right.equalTo(contentView).inset(24)
            make.bottom.equalTo(contentView).inset(32)
        }
    }
    
    @objc func dismissSelf(){
        dismiss(animated: true)
    }
}

extension BottomSheetViewController: UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: contentView) == true {
            return false
        }
        return true
    }
    
}
