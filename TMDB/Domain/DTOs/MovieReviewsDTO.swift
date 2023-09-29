//
//  MovieReviewsDTO.swift
//  TMDB
//
//  Created by Radwa Ahmed on 30/08/2023.
//

import Foundation

struct MovieReviewsDTO: Decodable {
    let page: Int
    let noOfPages: Int
    let noOfReviews: Int
    let reviews: [MovieReviewDTO]
    
    init(
        page: Int,
        noOfPages: Int,
        noOfReviews: Int,
        reviews: [MovieReviewDTO]
    ) {
        self.page = page
        self.noOfPages = noOfPages
        self.noOfReviews = noOfReviews
        self.reviews = reviews
    }
    
    enum CodingKeys: String, CodingKey {
        case page
        case noOfPages = "total_pages"
        case noOfReviews = "total_results"
        case reviews = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.page = try container.decode(Int.self, forKey: .page)
        self.noOfPages = try container.decode(Int.self, forKey: .noOfPages)
        self.noOfReviews = try container.decode(Int.self, forKey: .noOfReviews)
        self.reviews = try container.decode([MovieReviewDTO].self, forKey: .reviews)
    }
}

struct MovieReviewDTO: Decodable {
    let id: String
    let authorName: String
    let content: String
    let creatingDate: String
    let updatingDate: String?
    let rating: Int?
    
    init(
        id: String,
        authorName: String,
        content: String,
        creatingDate: String,
        updatingDate: String?,
        rating: Int?
    ) {
        self.id = id
        self.authorName = authorName
        self.content = content
        self.creatingDate = creatingDate
        self.updatingDate = updatingDate
        self.rating = rating
    }
    
    enum AutherKey: String, CodingKey {
        case author = "author_details"
    }
    
    enum RatingKey: String, CodingKey {
        case rating
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case authorName = "author"
        case content
        case creatingDate = "created_at"
        case updatingDate = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.authorName = try container.decode(String.self, forKey: .authorName)
        self.content = try container.decode(String.self, forKey: .content)
        self.creatingDate = try container.decode(String.self, forKey: .creatingDate)
        self.updatingDate = try container.decodeIfPresent(String.self, forKey: .updatingDate)
        
        let authorContainer = try decoder.container(keyedBy: AutherKey.self)
        let ratingContainer = try authorContainer.nestedContainer(keyedBy: RatingKey.self, forKey: .author)
        self.rating = try ratingContainer.decodeIfPresent(Int.self, forKey: .rating)
    }
}
