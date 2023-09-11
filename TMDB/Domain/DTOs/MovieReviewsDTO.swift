//
//  MovieReviewsDTO.swift
//  TMDB
//
//  Created by Radwa Ahmed on 30/08/2023.
//

import Foundation

struct MovieReviewsDTO: Decodable {
    let page : Int
    let noOfPages: Int
    let noOfReviews: Int
    let reviews: [MovieReviewDTO]
    
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
    
    enum AutherKey: String, CodingKey {
        case author = "author_details"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case authorName = "author"
        case content
        case creatingDate = "created_at"
        case updatingDate = "updated_at"
        case rating
    }
    
    init(from decoder: Decoder) throws {
        let author = try decoder.container(keyedBy: AutherKey.self)
        let container = try author.nestedContainer(keyedBy: CodingKeys.self, forKey: .author)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.authorName = try container.decode(String.self, forKey: .authorName)
        self.content = try container.decode(String.self, forKey: .content)
        self.creatingDate = try container.decode(String.self, forKey: .creatingDate)
        self.updatingDate = try container.decodeIfPresent(String.self, forKey: .updatingDate)
        self.rating = try container.decodeIfPresent(Int.self, forKey: .rating)
    }
}
