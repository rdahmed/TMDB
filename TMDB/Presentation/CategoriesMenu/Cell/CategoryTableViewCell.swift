//
//  CategoryTableViewCell.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    // MARK: - Dependencies
    
    var category: MovieCategory? {
        didSet {
            guard let category = self.category else { return }
            self.updateUI(category)
        }
    }
    
    // MARK: - Properties
    
    let containerView = UIView()
    let titleLabel = UILabel()
    
    // MARK: - Initializers
            
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupLayout()
        self.setupConstraints()
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(#function, #file)
    }
    
}

// MARK: - UI Setup

private extension CategoryTableViewCell {
    
    func setupLayout() {
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.titleLabel)
    }
    
    func setupConstraints() {
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.containerView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.containerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.containerView.heightAnchor.constraint(equalToConstant: 48),
            self.containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            
            self.titleLabel.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor)
        ])
    }
    
    func setupViews() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        
        self.containerView.layer.cornerRadius = 8
        self.containerView.backgroundColor = .accentColor
        
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = .primaryTintColor
        self.titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    
    func updateUI(_ category: MovieCategory) {
        self.titleLabel.text = category.title
    }
    
}
