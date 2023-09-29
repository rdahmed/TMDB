//
//  ReviewTableViewCell.swift
//  TMDB
//
//  Created by Radwa Ahmed on 11/09/2023.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    // MARK: - Dependencies
    
    var review: MovieReview? {
        didSet {
            guard let review else { return }
            self.updateUI(review)
        }
    }
    
    var randomColor: UIColor {
        return UIColor(
            red: (.random(in: 5...250) / 255),
            green: (.random(in: 5...250) / 255),
            blue: (.random(in: 5...250) / 255),
            alpha: 1
        )
    }
    
    // MARK: - Properties
    
    private let reviewerImageView = UIView()
    private let reviewerFirstLabel = UILabel()
    private lazy var reviewerImageViewSubviews: [UIView] = {
        return [self.reviewerFirstLabel]
    }()
    
    private let reviewerNameLabel = UILabel()
    
    private let ratingView = UIView()
    private let starImageView = UIImageView(image: .init(systemName: "star.fill"))
    private let ratingLabel = UILabel()
    private lazy var ratingViewSubviews: [UIView] = {
        return [self.starImageView, self.ratingLabel]
    }()
    
    private let reviewContentLabel = UILabel()
    private lazy var contentViewSubviews: [UIView] = {
        return [
            self.reviewerImageView,
            self.reviewerNameLabel,
            self.ratingView,
            self.reviewContentLabel
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

private extension ReviewTableViewCell {
    
    func setupLayout() {
        self.contentViewSubviews.forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.reviewerImageViewSubviews.forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.ratingViewSubviews.forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        let contentLabelBottomConstraint = self.reviewContentLabel.bottomAnchor.constraint(
            equalTo: self.contentView.bottomAnchor,
            constant: -8
        )
        contentLabelBottomConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            self.reviewerImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.reviewerImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.reviewerImageView.heightAnchor.constraint(equalToConstant: 40),
            self.reviewerImageView.widthAnchor.constraint(equalToConstant: 40),
            
            self.reviewerFirstLabel.centerYAnchor.constraint(equalTo: self.reviewerImageView.centerYAnchor),
            self.reviewerFirstLabel.centerXAnchor.constraint(equalTo: self.reviewerImageView.centerXAnchor),
            
            self.reviewerNameLabel.topAnchor.constraint(equalTo: self.reviewerImageView.topAnchor),
            self.reviewerNameLabel.leadingAnchor.constraint(equalTo: self.reviewerImageView.trailingAnchor, constant: 8),
            self.reviewerNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            
            self.ratingView.heightAnchor.constraint(equalToConstant: 20),
            self.ratingView.topAnchor.constraint(equalTo: self.reviewerNameLabel.bottomAnchor, constant: 2),
            self.ratingView.leadingAnchor.constraint(equalTo: self.reviewerNameLabel.leadingAnchor),
            
            self.starImageView.heightAnchor.constraint(equalToConstant: 10),
            self.starImageView.widthAnchor.constraint(equalToConstant: 10),
            self.starImageView.centerYAnchor.constraint(equalTo: self.ratingView.centerYAnchor),
            self.starImageView.leadingAnchor.constraint(equalTo: self.ratingView.leadingAnchor, constant: 8),
            
            self.ratingLabel.centerYAnchor.constraint(equalTo: self.starImageView.centerYAnchor),
            self.ratingLabel.leadingAnchor.constraint(equalTo: self.starImageView.trailingAnchor, constant: 4),
            self.ratingLabel.trailingAnchor.constraint(equalTo: self.ratingView.trailingAnchor, constant: -8),
            
            self.reviewContentLabel.topAnchor.constraint(equalTo: self.reviewerImageView.bottomAnchor, constant: 10),
            self.reviewContentLabel.leadingAnchor.constraint(equalTo: self.reviewerImageView.trailingAnchor),
            self.reviewContentLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            contentLabelBottomConstraint
        ])
        
        self.contentView.layoutIfNeeded()
    }
    
    func setupViews() {
        self.setupReviewerImageView()
        self.setupReviewerNameLabel()
        self.setupRatingView()
        self.setupReviewContentLabel()
    }
    
    func setupReviewerImageView() {
        self.reviewerImageView.circular()
        self.reviewerImageView.backgroundColor = self.randomColor
        
        self.reviewerFirstLabel.textAlignment = .center
        self.reviewerFirstLabel.textColor = .white
        self.reviewerFirstLabel.font = .systemFont(ofSize: 20)
    }
    
    func setupReviewerNameLabel() {
        self.reviewerNameLabel.textAlignment = .left
        self.reviewerNameLabel.textColor = .primaryTextColor
        self.reviewerNameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    func setupRatingView() {
        self.ratingView.rounded()
        self.ratingView.backgroundColor = .black
        
        self.starImageView.tintColor = .white
        
        self.ratingLabel.textAlignment = .center
        self.ratingLabel.textColor = .white
        self.ratingLabel.font = .systemFont(ofSize: 12, weight: .medium)
    }
    
    func setupReviewContentLabel() {
        self.reviewContentLabel.numberOfLines = 0
        self.reviewContentLabel.textAlignment = .left
        self.reviewContentLabel.textColor = .secondaryTextColor
        self.reviewContentLabel.font = .systemFont(ofSize: 14)
    }
    
    func updateUI(_ review: MovieReview) {
        let reviewerFirst = review.authorName.first ?? "?"
        self.reviewerFirstLabel.text = "\(reviewerFirst)"
        self.reviewerNameLabel.text = review.authorName
        self.ratingLabel.text = "\((review.rating ?? 0) / 2).0"
        self.reviewContentLabel.text = review.content
    }
    
}
