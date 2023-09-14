//
//  PosterTableViewCell.swift
//  TMDB
//
//  Created by Radwa Ahmed on 08/09/2023.
//

import UIKit

protocol HeaderCellDelegate: AnyObject {
    func didTapRatingButton()
}

class PosterTableViewCell: UITableViewCell {
    
    // MARK: - Dependencies
    
    var isMovieRated = false {
        didSet {
            self.ratingButton.configuration?.baseForegroundColor = self.isMovieRated ? .yellow : .white
        }
    }
    var details: MovieDetails? {
        didSet {
            guard let details else { return }
            self.updateUI(details)
        }
    }
    var delegate: HeaderCellDelegate?
    
    // MARK: - Properties
    
    private let backdropImageView = UIImageView()
    private let overlayerView = UIView()
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let detailsLabel = UILabel()
    private let userScoreView = UserScoreView()
    private let userScoreLabel = UILabel()
    private let ratingButton = UIButton()
    private lazy var contentViewSubviews: [UIView] = {
        return [
            self.backdropImageView,
            self.overlayerView,
            self.posterImageView,
            self.titleLabel,
            self.detailsLabel,
            self.userScoreView,
            self.userScoreLabel,
            self.ratingButton
        ]
    }()
    
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

private extension PosterTableViewCell {
    
    func setupLayout() {
        self.contentViewSubviews.forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.backdropImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.backdropImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.backdropImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.backdropImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            self.overlayerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.overlayerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.overlayerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.overlayerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            self.posterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.posterImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            self.posterImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            self.posterImageView.widthAnchor.constraint(equalToConstant: 120),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.posterImageView.topAnchor, constant: 8),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.posterImageView.trailingAnchor, constant: 10),
            self.titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: 12),
            
            self.detailsLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
            self.detailsLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.detailsLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
                        
            self.userScoreView.heightAnchor.constraint(equalToConstant: 50),
            self.userScoreView.widthAnchor.constraint(equalToConstant: 50),
            self.userScoreView.topAnchor.constraint(equalTo: self.detailsLabel.bottomAnchor, constant: 8),
            self.userScoreView.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            
            self.userScoreLabel.centerYAnchor.constraint(equalTo: self.userScoreView.centerYAnchor),
            self.userScoreLabel.leadingAnchor.constraint(equalTo: self.userScoreView.trailingAnchor, constant: 2),
            
            self.ratingButton.heightAnchor.constraint(equalToConstant: 40),
            self.ratingButton.widthAnchor.constraint(equalToConstant: 40),
            self.ratingButton.centerYAnchor.constraint(equalTo: self.userScoreView.centerYAnchor),
            self.ratingButton.leadingAnchor.constraint(equalTo: self.userScoreLabel.trailingAnchor, constant: 8)
        ])
        
        self.contentView.layoutIfNeeded()
    }
    
    func setupViews() {
        self.setupImages()
        self.setupTitleLabel()
        self.setupDetailsLabel()
        self.setupUserScoreView()
        self.setupRatingButton()
    }
    
    func setupImages() {
        self.backdropImageView.backgroundColor = .accentColor
        self.backdropImageView.contentMode = .scaleToFill
        
        self.overlayerView.backgroundColor = .darkGray.withAlphaComponent(0.5)
        
        self.posterImageView.contentMode = .scaleAspectFill
        self.posterImageView.rounded()
    }
    
    func setupTitleLabel() {
        self.titleLabel.textAlignment = .left
        self.titleLabel.textColor = .white
        self.titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    func setupDetailsLabel() {
        self.detailsLabel.numberOfLines = 2
        self.detailsLabel.textAlignment = .left
        self.detailsLabel.textColor = .white
        self.detailsLabel.font = .systemFont(ofSize: 12, weight: .medium)
    }
    
    func setupUserScoreView() {
        self.userScoreView.circular()
        self.userScoreView.font = .systemFont(ofSize: 18, weight: .bold)
        
        self.userScoreLabel.numberOfLines = 2
        self.userScoreLabel.textAlignment = .left
        self.userScoreLabel.textColor = .white
        self.userScoreLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        self.userScoreLabel.text = "User\nScore"
    }
    
    func setupRatingButton() {
        self.ratingButton.circular()
        
        var config = UIButton.Configuration.filled()
        let starImage = UIImage(systemName: "star.fill")?.withTintColor(.white)
        config.image = starImage
        config.preferredSymbolConfigurationForImage = .init(pointSize: 10)
        config.baseBackgroundColor = .accentColor.withAlphaComponent(0.8)
        self.ratingButton.configuration = config
        
        self.ratingButton.addTarget(self, action: #selector(self.ratingButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func ratingButtonTapped() {
        self.delegate?.didTapRatingButton()
    }
    
    func updateUI(_ details: MovieDetails) {
        if let backdropData = details.backdropData {
            self.backdropImageView.image = UIImage(data: backdropData)
        }
        
        if let posterData = details.posterData {
            self.posterImageView.image = UIImage(data: posterData)
        }
        
        self.titleLabel.text = details.title
        
        let releaseDate = details.releaseDate
        let duration = details.duration
        if let genres = details.genres?.joined(separator: ", ") {
            self.detailsLabel.text = releaseDate + " • " + duration + "\n\(genres)"
        } else {
            self.detailsLabel.text = releaseDate + " • " + duration
        }
        
        self.userScoreView.vote = details.averageVote
    }
    
}
