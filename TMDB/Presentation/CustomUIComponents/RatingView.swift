//
//  RatingView.swift
//  TMDB
//
//  Created by Radwa Ahmed on 14/09/2023.
//

import UIKit

protocol RatingViewDelegate: AnyObject {
    func dimissRatingView(_ rating: Double?)
}

class RatingView: BaseUIView {
    
    private enum Constants {
        static let starHeight: CGFloat = 60
        static let boxHeight: CGFloat = 120
        static let buttonHeight: CGFloat = 40
    }
    
    private enum StarImageType {
        case filled
        case halfFilled
        case regular
        
        var systemName: String {
            switch self {
            case .filled: return "star.fill"
            case .halfFilled: return "star.leadinghalf.filled"
            case .regular: return "star"
            }
        }
    }
    
    // MARK: - Dependencies
    
    var rating: Double? {
        didSet {
            self.updateUI(self.rating)
        }
    }
    var delegate: RatingViewDelegate?
    
    // MARK: - Properties
    
    private let stackView = UIStackView()
    private let ratingBoxView = UIView()
    private let doneButton = UIButton()
    private let removeButton = UIButton()
    private lazy var stackViewSubviews: [UIView] = {
        return [self.ratingBoxView, self.doneButton, self.removeButton]
    }()
    
    private let starsStackView = UIStackView()
    
    // MARK: - Initializers
    
    override func initializer() {
        self.setupLayout()
        self.setupConstraints()
        self.setupViews()
    }
    
}

private extension RatingView {
    
    func setupLayout() {
        self.addSubview(self.stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.stackViewSubviews.forEach {
            self.stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.ratingBoxView.addSubview(self.starsStackView)
        self.starsStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -40),
            self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            self.ratingBoxView.heightAnchor.constraint(equalToConstant: Constants.boxHeight),
            
            self.doneButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            self.removeButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            
            self.starsStackView.topAnchor.constraint(equalTo: self.ratingBoxView.topAnchor),
            self.starsStackView.leadingAnchor.constraint(equalTo: self.ratingBoxView.leadingAnchor, constant: 8),
            self.starsStackView.trailingAnchor.constraint(equalTo: self.ratingBoxView.trailingAnchor, constant: -8),
            self.starsStackView.bottomAnchor.constraint(equalTo: self.ratingBoxView.bottomAnchor),
        ])
    }
    
    func setupViews() {
        self.backgroundColor = .black.withAlphaComponent(0.7)
        self.setupStackView()
        self.setupRatingBoxView()
        self.setupStarsStackView()
        self.setupDoneButton()
        self.setupRemoveButton()
        self.setupRatingGestureRecognizer()
        
        self.updateUI(self.rating)
    }
    
    func setupStackView() {
        self.stackView.axis = .vertical
        self.stackView.spacing = 4
        self.stackView.alignment = .fill
        self.stackView.distribution = .equalSpacing
    }
    
    func setupRatingBoxView() {
        self.ratingBoxView.backgroundColor = .accentColor
        self.ratingBoxView.rounded()
    }
    
    func setupStarsStackView() {
        self.starsStackView.axis = .horizontal
        self.starsStackView.spacing = 2
        self.starsStackView.alignment = .center
        self.starsStackView.distribution = .equalSpacing
        
        self.starsStackView.isUserInteractionEnabled = true
    }
    
    func setupDoneButton() {
        self.doneButton.rounded()
        self.doneButton.backgroundColor = .white.withAlphaComponent(0.7)
        self.doneButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        self.doneButton.setTitleColor(.accentColor, for: .normal)
        self.doneButton.setTitle("Done", for: .normal)
        
        self.doneButton.addTarget(self, action: #selector(self.doneButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func doneButtonTapped() {
        self.delegate?.dimissRatingView(self.rating)
    }
    
    func setupRemoveButton() {
        self.removeButton.rounded()
        self.removeButton.backgroundColor = .white.withAlphaComponent(0.8)
        self.removeButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        self.removeButton.setTitleColor(.red, for: .normal)
        self.removeButton.setTitle("Remove Your Rating", for: .normal)
        
        self.removeButton.addTarget(self, action: #selector(self.removeButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func removeButtonTapped() {
        self.rating = nil
        self.delegate?.dimissRatingView(nil)
    }
    
    func setupRatingGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.didTapOnStar(_:))
        )
        self.starsStackView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc
    func didTapOnStar(_ sender: UITapGestureRecognizer) {
        for idx in 0..<self.starsStackView.arrangedSubviews.count {
            let subview = self.starsStackView.arrangedSubviews[idx]
            let location = sender.location(in: subview)
            if let _ = subview.hitTest(location, with: nil) {
                self.rating = location.x <= subview.bounds.midX
                ? Double(idx) + 0.5
                : Double(idx + 1)
            }
        }
    }
    
    func updateUI(_ rating: Double?) {
        self.starsStackView.arrangedSubviews.forEach {
            self.starsStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        
        guard let rating, rating != 0 else {
            for _ in 1...5 {
                self.starsStackView.addArrangedSubview(self.starImageView(.regular))
            }
            return
        }
        
        guard rating >= 1 else {
            self.starsStackView.addArrangedSubview(self.starImageView(.halfFilled))
            for _ in 2...5 {
                self.starsStackView.addArrangedSubview(self.starImageView(.regular))
            }
            return
        }
        
        for _ in 1...Int(rating) {
            self.starsStackView.addArrangedSubview(self.starImageView(.filled))
        }
        
        var next = (Int(rating) + 1)
        
        if rating != Double(Int(rating)) {
            self.starsStackView.addArrangedSubview(self.starImageView(.halfFilled))
            next += 1
        }
        
        guard next <= 5 else { return }
        for _ in next...5 {
            self.starsStackView.addArrangedSubview(self.starImageView(.regular))
        }
        
        self.starsStackView.layoutIfNeeded()
    }
    
    private func starImageView(_ type: StarImageType) -> UIImageView {
        let imageView = UIImageView()
        imageView.tintColor = .yellow
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        
        imageView.heightAnchor.constraint(equalToConstant: Constants.starHeight).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.starHeight).isActive = true
        
        imageView.image = UIImage(systemName: type.systemName)
        
        return imageView
    }
    
}
