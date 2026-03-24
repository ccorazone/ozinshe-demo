//
//  MoviesCellView.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 12.12.2025.
//
import UIKit
import SnapKit
import SDWebImage

class MoviesCellView: UITableViewCell {
    
    lazy var posterImageView: UIImageView = createImageView(image: "Image")
    lazy var playImageView: UIImageView = createImageView(image: "Play")
    lazy var titleLabel = UILabel.createLabel(text: "Қызғалдақтар мекені ",
                                           font: UIFont(name: Fonts.bold.rawValue, size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .bold),
                                           color: Colors.Text.primary)
    lazy var subtitleLabel = UILabel.createLabel(text: "2020 • Телехикая • Мультфильм",
                                              font: UIFont(name: Fonts.regular.rawValue, size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .regular),
                                              color: Colors.Text.secondary, numberOfLines: 1)
    
    lazy var buttonTitle = UILabel.createLabel(text: "Қарау",
                                            font: UIFont(name: Fonts.bold.rawValue, size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .regular),
                                                 color: Colors.Text.purpleFont)
    
    lazy var buttonView : UIView = createView(color: Colors.View.viewLightPurple, cornerRadius: 8)
    
    //lazy var bottomView : UIView = createView(color: Colors.View.viewLigtGray, cornerRadius: 0)
    lazy var bottomView = SeparatorView()
    
    
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .primaryBackground
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(buttonView)
        buttonView.addSubview(playImageView)
        buttonView.addSubview(buttonTitle)
        contentView.addSubview(bottomView)
        if let token = UserDefaults.standard.string(forKey: "userToken") { // или как ты его хранишь
            SDWebImageDownloader.shared.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        setConstraints()

       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func createView(color: UIColor, cornerRadius: CGFloat) -> UIView {
        let view = UIView()
        //view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        view.layer.cornerRadius = cornerRadius
        //view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
    
    private func createImageView(image: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        //imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        
        return imageView
    }
    
    private func setConstraints(){
        
        posterImageView.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(24)
            make.bottom.equalTo(bottomView.snp.top).offset(-24)
            make.left.equalTo(contentView).offset(24)
            make.width.equalTo(71.02)
            make.height.equalTo(104)
        }
        titleLabel.snp.makeConstraints{make in
            make.top.equalTo(contentView).offset(24)
            make.left.equalTo(posterImageView.snp.right).offset(17)
            make.right.equalTo(contentView).inset(24)
            
        }
        subtitleLabel.snp.makeConstraints{make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(posterImageView.snp.right).offset(17)
            make.right.equalTo(contentView).inset(24)

        }
        buttonView.snp.makeConstraints{make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(24)
            make.left.equalTo(posterImageView.snp.right).offset(17)
            make.width.equalTo(80)
            make.height.equalTo(26)
        }
        playImageView.snp.makeConstraints{make in
            make.top.equalTo(buttonView).offset(5)
            make.left.equalTo(buttonView).offset(12)
            make.right.equalTo(buttonTitle.snp.left).offset(-4)
            make.bottom.equalTo(buttonView).inset(5)
        }
        
        buttonTitle.snp.makeConstraints{make in
            make.top.equalTo(buttonView).offset(5)
            make.right.equalTo(buttonView).inset(12)
        }
        
        bottomView.snp.makeConstraints{make in
            make.left.equalTo(contentView).offset(24)
            make.right.equalTo(contentView).inset(24)
            make.bottom.equalTo(contentView).inset(0)
            
        }
        
        
    }
    
    
    func setData(movie: Movie) {
        titleLabel.text = movie.name
        var titleComponents: [String] = []
        if let year = movie.year{
            titleComponents.append(String(year))

        }else{
            titleComponents.append("-")

        }
        let categories = movie.categories.map({$0.name})
        titleComponents.append(contentsOf: categories)
        subtitleLabel.text = titleComponents.joined(separator: " • ")
        
        if let link = movie.poster?.link {
            print("image: \(link)")
            let temp = link.replacingOccurrences(of: "api.ozinshe.com", with: "apiozinshe.mobydev.kz")
            let url = URL(string: temp)

            posterImageView.sd_setImage(with: url)
        }
        else{
            print("no image")
        }
    }
    
    
    
    
    
    
    
}


