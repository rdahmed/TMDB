//
//  MovieDetailsContracts.swift
//  TMDB
//
//  Created by Radwa Ahmed on 07/09/2023.
//

import Foundation

protocol MovieDetailsViewModelInputProtocol: AnyObject {
    func fetchDetails(completion: (() -> Void)?)
    func fetchCredits(completion: (() -> Void)?)
    func fetchReviews(completion: (() -> Void)?)
    func addRating(_ value: Double, completion: (() -> Void)?)
    func deleteRating(completion: (() -> Void)?)
}
