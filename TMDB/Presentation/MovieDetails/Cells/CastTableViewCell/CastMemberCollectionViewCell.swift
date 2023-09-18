//
//  CastMemberCollectionViewCell.swift
//  TMDB
//
//  Created by Radwa Ahmed on 08/09/2023.
//

import UIKit

class CastMemberCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Dependencies
    
    var castMember: MovieCastMember? {
        didSet {
            guard let castMember else { return }
            self.updateUI(castMember)
        }
    }
    
    // MARK: - Properties
    
    private let memberImageView = UIImageView()
    private let memberNameLabel = UILabel()
    private let characterNameLabel = UILabel()
    private lazy var contentViewSubviews: [UIView] = {
        return [
            self.memberImageView,
            self.memberNameLabel,
            self.characterNameLabel
        ]
    }()
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.memberImageView.image = nil
    }
    
}

// MARK: - UI Setup

private extension CastMemberCollectionViewCell {
    
    func setupLayout() {
        self.contentViewSubviews.forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.memberImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.memberImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.memberImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.memberImageView.heightAnchor.constraint(equalToConstant: 100),
            
            self.memberNameLabel.topAnchor.constraint(equalTo: self.memberImageView.bottomAnchor, constant: 4),
            self.memberNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.memberNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            
            self.characterNameLabel.topAnchor.constraint(equalTo: self.memberNameLabel.bottomAnchor, constant: 2),
            self.characterNameLabel.leadingAnchor.constraint(equalTo: self.memberNameLabel.leadingAnchor),
            self.characterNameLabel.trailingAnchor.constraint(equalTo: self.memberNameLabel.trailingAnchor),
            self.characterNameLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -4)
        ])
    }
    
    func setupViews() {
        self.shadowed()
        self.setupContentView()
        self.setupMemberImageView()
        self.setupMemberNameLabel()
        self.setupCharacterNameLabel()
    }
    
    func setupContentView() {
        self.contentView.backgroundColor = .white
        self.contentView.rounded()
    }
    
    func setupMemberImageView() {
        self.memberImageView.contentMode = .scaleAspectFill
        self.memberImageView.clipsToBounds = true
    }
    
    func setupMemberNameLabel() {
        self.memberNameLabel.numberOfLines = 2
        self.memberNameLabel.textAlignment = .left
        self.memberNameLabel.textColor = .primaryTextColor
        self.memberNameLabel.font = .systemFont(ofSize: 12, weight: .semibold)
    }
    
    func setupCharacterNameLabel() {
        self.characterNameLabel.textAlignment = .left
        self.characterNameLabel.textColor = .secondaryTextColor
        self.characterNameLabel.font = .systemFont(ofSize: 10, weight: .regular)
    }
    
    func updateUI(_ castMember: MovieCastMember) {
        self.memberImageView.showSpinner()
        UIImage.download(from: castMember.profileURL) { profileURL in
            if let profileURL {
                self.memberImageView.image = profileURL
            } else {
                self.memberImageView.image = UIImage(systemName: "person.fill")
                self.memberImageView.tintColor = .lightGray
            }
            self.memberImageView.hideSpinner()
        }
        
        self.memberNameLabel.text = castMember.name
        self.characterNameLabel.text = castMember.character
    }
    
}
