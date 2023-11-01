//
//  UserScoreView.swift
//  TMDB
//
//  Created by Radwa Ahmed on 08/09/2023.
//

import UIKit

class UserScoreView: BaseUIView {
    
    // MARK: - Dependencies
    
    var vote: Double? {
        didSet {
            self.updateUI(self.vote)
        }
    }
    
    var font: UIFont = .systemFont(ofSize: 10, weight: .bold) {
        didSet {
            self.userScoreLabel.font = self.font
            self.updateUI(self.vote)
        }
    }
    
    // MARK: - Properties
    
    let userScoreLabel = UILabel()
    
    // MARK: - Initializers
    
    override func initializer() {
        self.setupLayout()
        self.setupConstraints()
        self.setupViews()
    }
    
}

// MARK: - UI Setup

private extension UserScoreView {
    
    func setupLayout() {
        self.addSubview(self.userScoreLabel)
        self.userScoreLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.userScoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.userScoreLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func setupViews() {
        self.backgroundColor = .accentColor

        self.userScoreLabel.textAlignment = .center
        self.userScoreLabel.textColor = .white
        self.userScoreLabel.font = .systemFont(ofSize: 10, weight: .semibold)
    }
    
    func updateUI(_ vote: Double?) {
        if let vote, vote >= 1 {
            let percentageFont: UIFont = .systemFont(ofSize: self.font.pointSize / 2, weight: .semibold)
            let userScoreAttStr = NSMutableAttributedString(string: "\(Int(vote * 10))%")
            userScoreAttStr.setAttributes(
                [.font: percentageFont, .baselineOffset: self.font.pointSize / 2],
                range: .init(location: 2, length: 1)
            )
            self.userScoreLabel.attributedText = userScoreAttStr
            
            if vote >= 7 {
                self.bordered(.userScorePositiveColor)
            } else if vote >= 4 {
                self.bordered(.userScoreNeutralColor)
            } else {
                self.bordered(.userScoreNegativeColor)
            }
        } else {
            self.userScoreLabel.text = "NR"
            self.bordered(.userScoreNoColor)
        }
    }
    
}
