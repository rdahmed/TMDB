//
//  Movies.swift
//  TMDB
//
//  Created by Radwa Ahmed on 29/08/2023.
//

import Foundation
import CoreData

struct Movies {
    let noOfPages: Int
    let movies: [Movie]
    
    init(dto: MoviesDTO) {
        self.noOfPages = dto.noOfPages
        self.movies = dto.movies.map { Movie(dto: $0) }
    }
}

struct Movie: Codable {
    let id: Int
    let title: String
    let releaseDate: String
    let posterData: Data?
    let averageVote: Double?
    
    init(dto: MovieDTO) {
        self.id = dto.id
        self.title = dto.title
        self.releaseDate = dto.releaseDate.formatted("YYYY-MM-dd")
        if let posterPath = dto.posterPath,
           let posterURL = URL(string: HTTPConfig.imageBaseURL + posterPath),
           let data = try? Data(contentsOf: posterURL)
        {
            self.posterData = data
        } else {
            self.posterData = nil
        }   
        self.averageVote = dto.averageVote
    }
}

extension Movie: CoreDataModel {
    init(managedObject: NSManagedObject) {
        self.id = managedObject.value(forKey: "id") as? Int ?? 0
        self.title = managedObject.value(forKey: "title") as? String ?? .empty
        self.releaseDate = managedObject.value(forKey: "releaseDate") as? String ?? Date().formatted()
        self.posterData = managedObject.value(forKey: "posterData") as? Data
        self.averageVote = managedObject.value(forKey: "averageVote") as? Double
    }
    
    func mapToManagedObject(
        entity: NSEntityDescription,
        insertInto: NSManagedObjectContext
    ) -> NSManagedObject {
        let managedObject = NSManagedObject(entity: entity, insertInto: insertInto)
        managedObject.setValue(self.id, forKey: "id")
        managedObject.setValue(self.title, forKey: "title")
        managedObject.setValue(self.releaseDate, forKey: "releaseDate")
        managedObject.setValue(self.posterData, forKey: "posterData")
        managedObject.setValue(self.averageVote, forKey: "averageVote")
        
        return managedObject
    }
}
