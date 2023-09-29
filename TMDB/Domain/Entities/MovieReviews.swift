//
//  MovieReviews.swift
//  TMDB
//
//  Created by Radwa Ahmed on 30/08/2023.
//

import Foundation

struct MovieReviews {
    let noOfPages: Int
    let reviews: [MovieReview]
    
    init(dto: MovieReviewsDTO) {
        self.noOfPages = dto.noOfPages
        self.reviews = dto.reviews.map { MovieReview(dto: $0) }
    }
}

struct MovieReview {
    let id: String
    let authorName: String
    let content: String
    let creatingDate: String
    let updatingDate: String?
    let rating: Int?
    
    init(dto: MovieReviewDTO) {
        self.id = dto.id
        self.authorName = dto.authorName
        self.content = dto.content
        self.creatingDate = dto.creatingDate.formatted("YYYY-MM-dd'T'hh:mm:ss.SSS'Z'")
        self.updatingDate = dto.updatingDate?.formatted("YYYY-MM-dd'T'hh:mm:ss.SSS'Z'")
        self.rating = dto.rating
    }
}
