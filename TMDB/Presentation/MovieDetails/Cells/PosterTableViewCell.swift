//
//  PosterTableViewCell.swift
//  TMDB
//
//  Created by Radwa Ahmed on 08/09/2023.
//

import UIKit

class PosterTableViewCell: UITableViewCell {
    
    // MARK: - Dependencies
    
    var details: MovieDetails? {
        didSet {
            guard let details else { return }
            self.updateUI(details)
        }
    }
    
    // MARK: - Properties
    
    private let backdropImageView = UIImageView()
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let detailsLabel = UILabel()
    private let stackView = UIStackView()
    private lazy var contentViewSubviews: [UIView] = {
        return [
            self.backdropImageView,
            self.posterImageView,
            self.titleLabel,
            self.detailsLabel,
            self.stackView
        ]
    }()
    
    private let userScoreStackView = UIStackView()
    private let userScoreView = UserScoreView()
    private let userScoreLabel = UILabel()
    private lazy var userScoreStackViewSubviews: [UIView] = {
        return [self.userScoreView, self.userScoreLabel]
    }()
    
    private let rateButton = UIButton()
    private lazy var stackViewSubviews: [UIView] = {
        return [self.userScoreStackView, self.rateButton]
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
        
        self.userScoreStackViewSubviews.forEach {
            self.userScoreStackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.stackViewSubviews.forEach {
            self.stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.backdropImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.backdropImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.backdropImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.backdropImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            self.posterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.posterImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            self.posterImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            self.posterImageView.widthAnchor.constraint(equalToConstant: 40),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.posterImageView.topAnchor, constant: 8),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.posterImageView.trailingAnchor, constant: 10),
            self.titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: 12),
            
            self.detailsLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
            self.detailsLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.detailsLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
            
            self.userScoreView.heightAnchor.constraint(equalToConstant: 50),
            self.userScoreView.widthAnchor.constraint(equalToConstant: 50),
            
            self.rateButton.heightAnchor.constraint(equalToConstant: 40),
            self.rateButton.widthAnchor.constraint(equalToConstant: 40),
            
            self.stackView.topAnchor.constraint(equalTo: self.detailsLabel.bottomAnchor, constant: 8),
            self.stackView.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
            self.stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.posterImageView.bottomAnchor)
        ])
    }
    
    func setupViews() {
        self.setupImages()
        self.setupTitleLabel()
        self.setupDetailsLabel()
        self.setupUserScoreStackView()
        self.setupRateButton()
    }
    
    func setupImages() {
        self.backdropImageView.backgroundColor = .accentColor
        self.backdropImageView.contentMode = .scaleAspectFill
        
        self.posterImageView.contentMode = .scaleAspectFill
        self.posterImageView.rounded()
    }
    
    func setupTitleLabel() {
        self.titleLabel.textAlignment = .left
        self.titleLabel.textColor = .primaryTextColor
        self.titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
    func setupDetailsLabel() {
        self.detailsLabel.textAlignment = .left
        self.detailsLabel.textColor = .primaryTextColor
        self.detailsLabel.font = .systemFont(ofSize: 18, weight: .medium)
    }
    
    func setupUserScoreStackView() {
        self.userScoreStackView.spacing = 2
        self.userScoreStackView.alignment = .center
        self.userScoreStackView.distribution = .equalSpacing
        self.userScoreStackView.axis = .vertical
        
        self.userScoreLabel.numberOfLines = 2
        self.userScoreLabel.textAlignment = .left
        self.userScoreLabel.textColor = .primaryTextColor
        self.userScoreLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        self.userScoreLabel.text = "User\nScore"
    }
    
    func setupRateButton() {
        self.rateButton.backgroundColor = .accentColor.withAlphaComponent(0.5)
        self.rateButton.tintColor = .primaryTintColor
        self.rateButton.setImage(UIImage(named: "star.fill"), for: .normal)
        self.rateButton.addTarget(self, action: #selector(rateButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func rateButtonTapped() {
        // TODO: Rate movie logic
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
            self.detailsLabel.text = releaseDate + " • " + genres + " • " + duration
        } else {
            self.detailsLabel.text = releaseDate + " • " + duration
        }
        
        self.userScoreView.vote = details.averageVote
    }
    
}
