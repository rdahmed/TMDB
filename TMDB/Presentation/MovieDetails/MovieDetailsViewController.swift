//
//  MovieDetailsViewController.swift
//  TMDB
//
//  Created by Radwa Ahmed on 07/09/2023.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    private enum DetailsSections: Int, CaseIterable {
        case poster = 0
        case overview
        case cast
        case reviews
        
        var title: String {
            switch self {
            case .overview: return "Overview"
            case .cast: return "Full Cast & Crew"
            case .reviews: return "Reviews"
            default: return .empty
            }
        }
        
        var cell: (type: UITableViewCell.Type, id: String) {
            switch self {
            case .poster: return (PosterTableViewCell.self, "posterCellId")
            case .overview: return (OverviewTableViewCell.self, "overviewCellId")
            case .cast: return (CastTableViewCell.self, "castCellId")
            case .reviews: return (ReviewTableViewCell.self, "reviewCellId")
            }
        }
    }
    
    // MARK: - Dependencies
    
    private let viewModel: MovieDetailsViewModel
    
    // MARK: - Properties
    
    private let ratingView = RatingView()
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let spinnerView = UIView()
    private lazy var mainViewSubviews: [UIView] = {
        return [self.ratingView, self.tableView, self.spinnerView]
    }()
    
    // MARK: - Initializers
    
    init(viewModel: MovieDetailsViewModel) {
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
        
        self.setupLayout()
        self.setupConstraints()
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        self.showSpinner()
        self.viewModel.fetchDetails { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(arrayLiteral: 0, 1), with: .automatic)
                self?.hideSpinner()
            }
        }
        
        self.viewModel.fetchCredits { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 2), with: .automatic)
            }
        }
        
        self.viewModel.fetchReviews { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(integer: 3), with: .automatic)
            }
        }
        
    }
    
}

// MARK: - UI Setup

private extension MovieDetailsViewController {
    
    func setupLayout() {
        self.mainViewSubviews.forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.ratingView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.ratingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.ratingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.ratingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.spinnerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.spinnerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.spinnerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.spinnerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.view.layoutIfNeeded()
    }
    
    func setupViews() {
        self.view.backgroundColor = .white
        self.ratingView.delegate = self
        self.spinnerView.backgroundColor = .white
        self.setupTableView()
    }
    
    func setupTableView() {
        self.tableView.backgroundColor = .white
        self.tableView.separatorStyle = .none
        
        DetailsSections.allCases.forEach {
            self.tableView.register($0.cell.type, forCellReuseIdentifier: $0.cell.id)
        }
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func showSpinner() {
        self.view.bringSubviewToFront(self.spinnerView)
        self.spinnerView.showSpinner()
    }
    
    func hideSpinner() {
        self.view.bringSubviewToFront(self.tableView)
        self.spinnerView.hideSpinner()
    }
    
}

// MARK: - UITableViewDataSource

extension MovieDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        DetailsSections.allCases.count
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch DetailsSections.allCases[section] {
        case .reviews where !self.viewModel.reviews.isEmpty :
            return self.viewModel.reviews.count
        default:
            return 1
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        DetailsSections.allCases[section].title
    }
        
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        guard let section = DetailsSections(rawValue: indexPath.section) else { return .init() }
        
        var cell: UITableViewCell?
        switch section {
        case .poster:
            guard let posterCell = tableView.dequeueReusableCell(
                withIdentifier: section.cell.id,
                for: indexPath) as? PosterTableViewCell
            else { return .init() }
            
            posterCell.isMovieRated = (self.viewModel.rating != nil)
            posterCell.details = self.viewModel.details
            posterCell.delegate = self
            cell = posterCell
            
        case .overview:
            guard let overviewCell = tableView.dequeueReusableCell(
                withIdentifier: section.cell.id,
                for: indexPath) as? OverviewTableViewCell
            else { return .init() }
            
            overviewCell.overview = self.viewModel.details?.overview
            cell = overviewCell
            
        case .cast:
            guard let castCell = tableView.dequeueReusableCell(
                withIdentifier: section.cell.id,
                for: indexPath) as? CastTableViewCell
            else { return .init() }
            
            castCell.cast = self.viewModel.cast
            cell = castCell
            
        case .reviews:
            guard !self.viewModel.reviews.isEmpty else {
                let emptyReviewCell = UITableViewCell()
                emptyReviewCell.textLabel?.text = "Be first one to give a review!"
                return emptyReviewCell
            }
            
            guard let reviewCell = tableView.dequeueReusableCell(
                withIdentifier: section.cell.id,
                for: indexPath) as? ReviewTableViewCell
            else { return .init() }
            
            reviewCell.review = self.viewModel.reviews[indexPath.row]
            cell = reviewCell
        }
        
        return cell ?? .init()
    }
    
}

// MARK: - UITableViewDelegate

extension MovieDetailsViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        guard let section = DetailsSections(rawValue: indexPath.section) else { return .zero }
        
        switch section {
        case .poster: return 200
        case .cast: return 180
        default: return UITableView.automaticDimension
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        willDisplayFooterView view: UIView,
        forSection section: Int
    ) {
        guard section == DetailsSections.reviews.rawValue else { return }
        
        view.showSpinner()
        self.viewModel.fetchReviews {
            DispatchQueue.main.async {
                tableView.reloadSections(IndexSet(integer: section), with: .automatic)
            }
        }
    }
    
}

// MARK: - HeaderCellDelegate

extension MovieDetailsViewController: HeaderCellDelegate {
    
    func didTapRatingButton() {
        self.ratingView.rating = self.viewModel.rating
        self.view.bringSubviewToFront(self.ratingView)
    }
    
}

// MARK: - RatingViewDelegate

extension MovieDetailsViewController: RatingViewDelegate {
    
    func dimissRatingView(_ rating: Double?) {
        self.showSpinner()
        
        guard let rating else {
            self.viewModel.deleteRating { [weak self] in
                DispatchQueue.main.async {
                    self?.updateUI(nil)
                    self?.hideSpinner()
                }
            }
            return
        }
        
        self.viewModel.addRating(rating) { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI(rating)
                self?.hideSpinner()
            }
        }
    }
    
    private func updateUI(_ rating: Double?) {
        self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
    
}
