//
//  CastTableViewCell.swift
//  TMDB
//
//  Created by Radwa Ahmed on 08/09/2023.
//

import UIKit

class CastTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let cellId: String = "castMemberCellId"
        static let itemHeight: CGFloat = 160
        static let itemWidth: CGFloat = 64
        static let lineSpacing: CGFloat = 8
        static let interitemSpacing: CGFloat = 8
    }
    
    // MARK: - Dependencies
    
    var cast: [MovieCastMember] = []
    
    // MARK: - Properties
    
    private var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
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

private extension CastTableViewCell {
    
    func setupLayout() {
        self.collectionView = .init(frame: self.contentView.frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.contentView.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    func setupViews() {
        self.collectionView.backgroundColor = .clear
        self.collectionView.contentInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        self.collectionView.register(CastMemberCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellId)
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
}

// MARK: - UICollectionViewDataSource

extension CastTableViewCell: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        self.cast.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.cellId,
            for: indexPath) as? CastMemberCollectionViewCell
        else { return .init() }
        
        cell.castMember = self.cast[indexPath.item]
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CastTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: Constants.itemWidth, height: Constants.itemHeight)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.lineSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.interitemSpacing
    }
    
}
