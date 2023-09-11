//
//  OverviewTableViewCell.swift
//  TMDB
//
//  Created by Radwa Ahmed on 08/09/2023.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {
    
    // MARK: - Dependencies
    
    var overview: String? {
        didSet {
            self.updateUI(self.overview)
        }
    }
    
    // MARK: - Properties
    
    private let overviewLabel = UILabel()
    
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
    
}

// MARK: - UI Setup

private extension OverviewTableViewCell {
    
    func setupLayout() {
        self.contentView.addSubview(self.overviewLabel)
        self.overviewLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.overviewLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.overviewLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.overviewLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            self.overviewLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12)
        ])
    }
    
    func setupViews() {
        self.overviewLabel.numberOfLines = 0
        self.overviewLabel.textAlignment = .left
        self.overviewLabel.textColor = .secondaryTextColor
        self.overviewLabel.font = .systemFont(ofSize: 16)
    }
    
    func updateUI(_ overview: String?) {
        self.overviewLabel.text = overview ?? "Not available!"
    }
}
