//
//  MovieCollectionViewCell.swift
//  TMDB
//
//  Created by Radwa Ahmed on 01/09/2023.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Dependencies
    
    var movie: Movie? {
        didSet {
            guard let movie = self.movie else { return }
            self.updateUI(movie)
        }
    }
    
    // MARK: - Properties
    
    private let posterImageView = UIImageView()
    private let userScoreView = UserScoreView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private lazy var contentViewSubviews: [UIView] = {
        return [
            self.posterImageView,
            self.userScoreView,
            self.titleLabel,
            self.dateLabel
        ]
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupAccessibility()
        self.setupLayout()
        self.setupConstraints()
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.posterImageView.image = nil
    }
    
}

// MARK: - UI Setup

private extension MovieCollectionViewCell {
    
    func setupAccessibility() {
        self.contentView.accessibilityIdentifier = Accessibility.MoviesListIds.CollectionViewCell.contentView.rawValue
        self.posterImageView.accessibilityIdentifier = Accessibility.MoviesListIds.CollectionViewCell.posterImageView.rawValue
        self.titleLabel.accessibilityIdentifier = Accessibility.MoviesListIds.CollectionViewCell.titleLabel.rawValue
        self.dateLabel.accessibilityIdentifier = Accessibility.MoviesListIds.CollectionViewCell.dateLabel.rawValue
    }
    
    func setupLayout() {
        self.contentViewSubviews.forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.posterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.posterImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.posterImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.posterImageView.heightAnchor.constraint(equalToConstant: 160),
            
            self.userScoreView.centerYAnchor.constraint(equalTo: self.posterImageView.bottomAnchor),
            self.userScoreView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.userScoreView.heightAnchor.constraint(equalToConstant: 30),
            self.userScoreView.widthAnchor.constraint(equalToConstant: 30),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor, constant: 20),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.userScoreView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -12),
            
            self.dateLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
            self.dateLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.dateLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
            self.dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -8)
        ])
        
        self.contentView.layoutIfNeeded()
    }
    
    func setupViews() {
        self.shadowed()
        self.setupContentView()
        self.setupPosterImageView()
        self.setupTitleLabel()
        self.setupDateLabel()
        self.userScoreView.circular()
    }
    
    func setupContentView() {
        self.contentView.backgroundColor = .white
        self.contentView.rounded()
    }
    
    func setupPosterImageView() {
        self.posterImageView.contentMode = .scaleAspectFill
        self.posterImageView.clipsToBounds = true
    }
    
    func setupTitleLabel() {
        self.titleLabel.numberOfLines = 2
        self.titleLabel.textAlignment = .left
        self.titleLabel.textColor = .primaryTextColor
        self.titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    func setupDateLabel() {
        self.dateLabel.textAlignment = .left
        self.dateLabel.textColor = .secondaryTextColor
        self.dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
    }
    
    func updateUI(_ movie: Movie) {
        self.posterImageView.showSpinner()
        UIImage.download(from: movie.posterURL) { posterImage in
            if let posterImage {
                self.posterImageView.image = posterImage
            } else {
                self.posterImageView.image = UIImage(systemName: "popcorn")
                self.posterImageView.tintColor = .lightGray
            }
            self.posterImageView.hideSpinner()
        }
        
        self.userScoreView.vote = movie.averageVote
                
        self.titleLabel.text = movie.title
        self.dateLabel.text = movie.releaseDate
    }
    
}
