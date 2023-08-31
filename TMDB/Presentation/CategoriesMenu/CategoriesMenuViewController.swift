//
//  CategoriesMenuViewController.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import UIKit

class CategoriesMenuViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let cellId = "categoryCellId"
    }
    
    // MARK: - Dependencies
    
    private let viewModel: CategoriesMenuViewModelInputProtocol
    
    // MARK: - Properties
    
    private var tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Initializers
    
    init(viewModel: CategoriesMenuViewModelInputProtocol) {
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
        
        self.setupViews()
        self.setupLayout()
        self.setupConstraints()
    }
    
}

// MARK: - UI Setup

private extension CategoriesMenuViewController {
    
    func setupViews() {
        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: Constants.cellId)
    }
    
    func setupLayout() {
        self.view.addSubview(self.tableView)
    }
    
    func setupConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40)
        ])
    }
    
}

// MARK: - UITableViewDataSource

extension CategoriesMenuViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        self.viewModel.categories.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellId,
            for: indexPath
        ) as? CategoryTableViewCell
        else { return .init() }
        
        cell.category = self.viewModel.categories[indexPath.row]
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension CategoriesMenuViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        64
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        self.viewModel.didTapOnCategory(self.viewModel.categories[indexPath.row])
    }
    
}
