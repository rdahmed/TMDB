//
//  MovieReview.swift
//  TMDB
//
//  Created by Radwa Ahmed on 30/08/2023.
//

import Foundation

typealias MovieReviews = [MovieReview]

struct MovieReview {
    let id: String
    let authorName: String
    let content: String
    let creatingDate: String
    let updatingDate: String?
    let url: String?
    
    init(dto: MovieReviewDTO) {
        self.id = dto.id
        self.authorName = dto.authorName
        self.content = dto.content
        self.creatingDate = dto.creatingDate.formatted("YYYY-MM-dd'T'hh:mm:ss.SSS'Z'")
        self.updatingDate = dto.updatingDate?.formatted("YYYY-MM-dd'T'hh:mm:ss.SSS'Z'")
        self.url = dto.url
    }
}
