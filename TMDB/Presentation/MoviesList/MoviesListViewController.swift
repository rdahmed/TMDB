//
//  MoviesListViewController.swift
//  TMDB
//
//  Created by Radwa Ahmed on 01/09/2023.
//

import UIKit

class MoviesListViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let cellId: String = "movieCellId"
        static let numberOfItemsInRow: Int = 3
        static let rowHeight: CGFloat = 240
        static let lineSpacing: CGFloat = 8
        static let interitemSpacing: CGFloat = 8
    }
    
    // MARK: - Dependencies
    
    private let viewModel: MoviesListViewModel
    private var bottomSpinnerViewHeightConstraint = NSLayoutConstraint()
    
    // MARK: - Properties
    
    private var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private let bottomSpinnerView = UIView()
    private lazy var mainViewSubviews: [UIView] = {
        return [self.collectionView, self.bottomSpinnerView]
    }()
    
    // MARK: - Initializers
    
    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(#function, #file)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeCollectionView()
        self.setupAccessbility()
        self.setupLayout()
        self.setupConstraints()
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.showSpinner()
        self.viewModel.fetchMovies() { [weak self] in
            self?.collectionView.reloadData()
            self?.view.hideSpinner()
        }
    }
    
}

// MARK: - UI Setup

private extension MoviesListViewController {
    
    func initializeCollectionView() {
        self.collectionView = .init(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    func setupAccessbility() {
        self.view.accessibilityIdentifier = Accessibility.MoviesListIds.viewController.rawValue
        self.collectionView.accessibilityIdentifier = Accessibility.MoviesListIds.collectionView.rawValue
    }
    
    func setupLayout() {
        self.mainViewSubviews.forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        self.bottomSpinnerViewHeightConstraint = .init(
            item: self.bottomSpinnerView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0
        )
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.bottomSpinnerView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor),
            self.bottomSpinnerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.bottomSpinnerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.bottomSpinnerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.bottomSpinnerViewHeightConstraint
        ])
    }
    
    func setupViews() {
        self.navigationItem.title = "\(self.viewModel.category.title) Movies"
        
        self.view.backgroundColor = .white
        
        self.collectionView.backgroundColor = .clear
        self.collectionView.contentInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        self.collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellId)
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func showBottomSpinner() {
        self.bottomSpinnerViewHeightConstraint.constant = 70
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        self.bottomSpinnerView.showSpinner()
    }
    
    func hideBottomSpinner() {
        self.bottomSpinnerViewHeightConstraint.constant = 0
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        self.bottomSpinnerView.hideSpinner()
    }
    
}

// MARK: - UICollectionViewDataSource

extension MoviesListViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        self.viewModel.movies.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.cellId,
            for: indexPath) as? MovieCollectionViewCell
        else { return .init() }
        
        cell.movie = self.viewModel.movies[indexPath.item]
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension MoviesListViewController: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if indexPath.item == self.viewModel.movies.count - 1 {
            self.showBottomSpinner()
            self.viewModel.fetchMovies() { [weak self] in
                self?.collectionView.reloadData()
                self?.hideBottomSpinner()
            }
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let selectedMovie = self.viewModel.movies[indexPath.row]
        self.viewModel.didTapOnMovie(selectedMovie.id)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MoviesListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.cellWidth(numberOfItemsInRow: Constants.numberOfItemsInRow)
        return CGSize(width: width, height: Constants.rowHeight)
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
