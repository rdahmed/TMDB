//
//  CategoriesMenuViewController.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import UIKit

class CategoriesMenuViewController: UIViewController {
    
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
    
}
