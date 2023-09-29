//
//  Error+Mock.swift
//  TMDBTests
//
//  Created by Radwa Ahmed on 18/09/2023.
//

@testable import TMDB
import Foundation

enum ErrorMock: Error {
    case fakeError
}

extension ErrorMock: LocalizedError {
    private var errorDescription: String {
        switch self {
        case .fakeError: return "A fake error message"
        }
    }
}
