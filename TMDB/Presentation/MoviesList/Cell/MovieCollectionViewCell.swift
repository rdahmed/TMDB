//
//  MovieCollectionViewCell.swift
//  TMDB
//
//  Created by Radwa Ahmed on 01/09/2023.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let posterImageHeight: CGFloat = 160
        static let userScoreViewHeight: CGFloat = 30
    }
    
    // MARK: - Dependencies
    
    var movie: Movie? {
        didSet {
            guard let movie = self.movie else { return }
            self.updateUI(movie)
        }
    }
    
    // MARK: - Properties
    
    let posterImageView = UIImageView()
    let userScoreView = UIView()
    let userScoreLabel = UILabel()
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupLayout()
        self.setupConstraints()
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI Setup

private extension MovieCollectionViewCell {
    
    func setupLayout() {
        self.contentView.addSubview(self.posterImageView)
        self.contentView.addSubview(self.userScoreView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.dateLabel)
        
        self.userScoreView.addSubview(self.userScoreLabel)
    }
    
    func setupConstraints() {
        self.posterImageView.translatesAutoresizingMaskIntoConstraints = false
        self.userScoreView.translatesAutoresizingMaskIntoConstraints = false
        self.userScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.posterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.posterImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.posterImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.posterImageView.heightAnchor.constraint(equalToConstant: Constants.posterImageHeight),
            
            self.userScoreView.centerYAnchor.constraint(equalTo: self.posterImageView.bottomAnchor),
            self.userScoreView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.userScoreView.heightAnchor.constraint(equalToConstant: Constants.userScoreViewHeight),
            self.userScoreView.widthAnchor.constraint(equalToConstant: Constants.userScoreViewHeight),
            self.userScoreLabel.centerXAnchor.constraint(equalTo: self.userScoreView.centerXAnchor),
            self.userScoreLabel.centerYAnchor.constraint(equalTo: self.userScoreView.centerYAnchor),
            
            self.nameLabel.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor, constant: 20),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.userScoreView.leadingAnchor),
            self.nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -12),
            
            self.dateLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 2),
            self.dateLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor),
            self.dateLabel.trailingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor),
            self.dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -8)
        ])
        
        self.contentView.layoutIfNeeded()
    }
    
    func setupViews() {
        self.shadowed()
        self.setupContentView()
        self.setupPosterImageView()
        self.setupNameLabel()
        self.setupDateLabel()
        self.setupUserScoreView()
    }
    
    func setupContentView() {
        self.contentView.backgroundColor = .white
        self.contentView.rounded()
    }
    
    func setupPosterImageView() {
        self.posterImageView.contentMode = .scaleAspectFill
        self.posterImageView.clipsToBounds = true
    }
    
    func setupNameLabel() {
        self.nameLabel.numberOfLines = 2
        self.nameLabel.textAlignment = .left
        self.nameLabel.textColor = .primaryTextColor
        self.nameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    func setupDateLabel() {
        self.dateLabel.textAlignment = .left
        self.dateLabel.textColor = .secondaryTextColor
        self.dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
    }
    
    func setupUserScoreView() {
        self.userScoreView.backgroundColor = .accentColor
        self.userScoreView.circular()

        self.userScoreLabel.textAlignment = .center
        self.userScoreLabel.textColor = .primaryTintColor
        self.userScoreLabel.font = .systemFont(ofSize: 10, weight: .semibold)
    }
    
    func updateUI(_ movie: Movie) {
        if let posterData = movie.posterData,
           let posterImage = UIImage(data: posterData)
        {
            self.posterImageView.image = posterImage
        } else {
            self.posterImageView.image = UIImage(systemName: "popcorn")
            self.posterImageView.tintColor = .lightGray
        }
        
        if let vote = movie.averageVote, vote >= 1 {
            let percentageFont: UIFont = .systemFont(ofSize: 6, weight: .semibold)
            let userScoreAttStr = NSMutableAttributedString(string: "\(Int(vote * 10))%")
            userScoreAttStr.setAttributes(
                [.font: percentageFont, .baselineOffset: 4],
                range: .init(location: 2, length: 1)
            )
            self.userScoreLabel.attributedText = userScoreAttStr
            
            if vote >= 7 {
                self.userScoreView.bordered(.userScorePositiveColor)
            } else if vote >= 4 {
                self.userScoreView.bordered(.userScoreNeutralColor)
            } else {
                self.userScoreView.bordered(.userScoreNegativeColor)
            }
        } else {
            self.userScoreLabel.text = "NR"
            self.userScoreView.bordered(.userScoreNoColor)
        }
                
        self.nameLabel.text = movie.title
        self.dateLabel.text = movie.releaseDate
    }
    
}
