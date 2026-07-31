//
//  CategoryDetailView.swift
//  ozinshe demo
//
//  Created by Мади Темешев on 01.04.2026.
//

import UIKit
import SnapKit

class MoviesListView: UIView{
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MoviesCellView.self, forCellReuseIdentifier: MoviesCellView.id)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .primaryBackground
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(tableView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints(){
        tableView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
}
