//
//  MoviesListViewModel.swift
//  TMDB
//
//  Created by Radwa Ahmed on 01/09/2023.
//

import Foundation

class MoviesListViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    private let category: MovieCategory
    private let service: MoviesServiceProtocol
    private let router: MoviesListRouter
    
    @Published var errorMessage: String?
    @Published var movies: [Movie] = []
    @Published var searchKeyword: String = ""
    
    private var currentPage = 0
    private var noOfPages = 1
    
    // MARK: - Initializers
    
    init(
        category: MovieCategory,
        service: MoviesServiceProtocol = MoviesService.default,
        router: MoviesListRouter
    ) {
        self.category = category
        self.service = service
        self.router = router        
    }
    
    deinit {
        print(#function, #file)
    }
    
}

// MARK: - ViewModelInput

extension MoviesListViewModel: MoviesListViewModelInputProtocol {
    
    func fetchMovies(completion: (() -> Void)? = nil) {
        switch category {
        case .popular:
            self.service.getPopular(self.currentPage) { [weak self] result in
                self?.mapResult(result)
                completion?()
            }
            
        case .nowPlaying:
            self.service.getNowPlaying(self.currentPage) { [weak self] result in
                self?.mapResult(result)
                completion?()
            }
            
        case .upcoming:
            self.service.getUpcoming(self.currentPage) { [weak self] result in
                self?.mapResult(result)
                completion?()
            }
            
        case .topRated:
            self.service.getTopRated(self.currentPage) { [weak self] result in
                self?.mapResult(result)
                completion?()
            }
        }
    }
    
    func search(completion: (() -> Void)?) {
        self.service.search(self.searchKeyword, page: self.currentPage) { [weak self] result in
            self?.mapResult(result)
            completion?()
        }
    }
    
    private func mapResult(_ result: Result<Movies?, Error>) {
        guard self.currentPage < self.noOfPages else { return }
        
        self.currentPage += 1
        switch result {
        case .success(let movies):
            if let movies {
                self.noOfPages = movies.noOfPages
                if self.currentPage == 1 {
                    self.movies.removeAll()
                }
                self.movies.append(contentsOf: movies.movies)
            } else {
                self.errorMessage = NetworkServiceError.emptyResponse.errorDescription
            }
            
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }
    
    func didTapOnMovie(_ id: Int) {
        self.router.showMovieDetails(id)
    }
    
}
