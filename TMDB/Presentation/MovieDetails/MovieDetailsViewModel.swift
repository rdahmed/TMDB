//
//  MovieDetailsViewModel.swift
//  TMDB
//
//  Created by Radwa Ahmed on 07/09/2023.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    private let movieId: Int
    private let service: MovieDetailsServiceProtocol
    private let router: MovieDetailsRouter
    
    @Published var errorMessage: String?
    @Published var details: MovieDetails?
    @Published var cast: [MovieCastMember] = []
    @Published var reviews: [MovieReview] = []
    
    var currentPage = 0
    var noOfPages = 1
    
    // MARK: - Initializers
    
    init(
        movieId: Int,
        service: MovieDetailsServiceProtocol = MovieDetailsService.default,
        router: MovieDetailsRouter
    ) {
        self.movieId = movieId
        self.service = service
        self.router = router
    }
    
    deinit {
        print(#function, #file)
    }
    
}

// MARK: - ViewModelInput

extension MovieDetailsViewModel: MovieDetailsViewModelInputProtocol {
    
    func fetchDetails(completion: (() -> Void)?) {
        self.service.getDetails(self.movieId) { result in
            switch result {
            case .success(let details):
                if let details {
                    self.details = details
                } else {
                    self.errorMessage = NetworkServiceError.emptyResponse.errorDescription
                }
                
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func fetchCredits(completion: (() -> Void)?) {
        self.service.getCredits(self.movieId) { result in
            switch result {
            case .success(let cast):
                if let cast {
                    self.cast = cast
                } else {
                    self.errorMessage = NetworkServiceError.emptyResponse.errorDescription
                }
                
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func fetchReviews(completion: (() -> Void)?) {
        guard self.currentPage < self.noOfPages else { return }
        
        self.currentPage += 1
        self.service.getReviews(self.movieId) { result in
            switch result {
            case .success(let reviews):
                if let reviews {
                    self.noOfPages = reviews.noOfPages
                    if self.currentPage == 1 {
                        self.reviews.removeAll()
                    }
                    self.reviews.append(contentsOf: reviews.reviews)
                } else {
                    self.errorMessage = NetworkServiceError.emptyResponse.errorDescription
                }
                
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func addRating(_ value: Double, completion: (() -> Void)?) {
        self.service.addRating(self.movieId, value: value) { result in
            switch result {
            case .success(let added):
                if added {
                    // TODO: Save in CoreData
                } else {
                    self.errorMessage = NetworkServiceError.emptyResponse.errorDescription
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func deleteRating(completion: (() -> Void)?) {
        self.service.deleteRating(self.movieId) { result in
            switch result {
            case .success(let deleted):
                if deleted {
                    // TODO: Remove from CoreData
                } else {
                    self.errorMessage = NetworkServiceError.emptyResponse.errorDescription
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
}