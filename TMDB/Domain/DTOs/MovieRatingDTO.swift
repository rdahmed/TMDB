//
//  MovieRatingDTO.swift
//  TMDB
//
//  Created by Radwa Ahmed on 31/08/2023.
//

import Foundation

struct MovieRatingDTO: Decodable {
    let success: Bool
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.success = try container.decode(Bool.self, forKey: .success)
        self.statusCode = try container.decode(Int.self, forKey: .statusCode)
        self.statusMessage = try container.decode(String.self, forKey: .statusMessage)
    }
}
