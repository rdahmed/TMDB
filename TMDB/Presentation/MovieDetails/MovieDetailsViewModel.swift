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
    @Published var rating: Double?
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
        self.rating = MoviesRatingsLocalStore.default.ratings[self.movieId]
        
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
            completion?()
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
            completion?()
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
            completion?()
        }
    }
    
    func addRating(_ value: Double, completion: (() -> Void)?) {
        self.service.addRating(self.movieId, value: value) { result in
            switch result {
            case .success(let added):
                if added {
                    self.rating = value
                    MoviesRatingsLocalStore.default.ratings[self.movieId] = value
                } else {
                    self.errorMessage = NetworkServiceError.emptyResponse.errorDescription
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
            completion?()
        }
    }
    
    func deleteRating(completion: (() -> Void)?) {
        self.service.deleteRating(self.movieId) { result in
            switch result {
            case .success(let deleted):
                if deleted {
                    self.rating = nil
                    MoviesRatingsLocalStore.default.ratings.removeValue(forKey: self.movieId)
                } else {
                    self.errorMessage = NetworkServiceError.emptyResponse.errorDescription
                }
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
            completion?()
        }
    }
    
}
