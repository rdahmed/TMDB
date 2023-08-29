//
//  NetworkService.swift
//  TMDB
//
//  Created by Radwa Ahmed on 29/08/2023.
//

import Foundation
import Combine

// MARK: - Network Service

class NetworkService: NetworkServiceProtocol {
    
    private init() {}
    static let shared: NetworkServiceProtocol = NetworkService()
    let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
        
    func request<T>(
        route: Route,
        method: HTTPMethod,
        queryItems: QueryItems = [:],
        headers: Headers = [:],
        body: HTTPBody = nil
    ) -> MoviesPublisher<T> {
        guard Reachability.shared.isReachable else {
            return Fail(error: NetworkServiceError.noInternetConnection).eraseToAnyPublisher()
        }
        
        guard let request = self.createRequest(
                route: route,
                method: method,
                queryItems: queryItems,
                headers: headers,
                body: body)
        else {
            return Fail(error: NetworkServiceError.invalidRequest).eraseToAnyPublisher()
        }

        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}

// MARK: - Request Helpers

private extension NetworkService {
    
    func createRequest(
        route: Route,
        method: HTTPMethod = .get,
        queryItems: QueryItems = [:],
        headers: Headers = [:],
        body: HTTPBody
    ) -> URLRequest? {
        guard let url = self.createURL(route, queryItems: queryItems) else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNGYyYjE2M2Y2ZGEzZTM2NGUwM2JkM2E2OThhMDNmZCIsInN1YiI6IjY0ZTQ3NjQzZTg5NGE2MDBlNGU0NmM0ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ._mtmSF0fc1UKMoBv31ays6uugHwB5ifohFc5w4L_Gvs", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        return request
    }
    
    func createURL(_ route: Route, queryItems: QueryItems = [:]) -> URL? {
        var urlString = HTTPConfig.baseURL + route.path
        
        let queryString = self.createQueryString(queryItems)
        urlString.append(queryString)
        
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed).orEmpty
        
        return URL(string: urlString)
    }
    
    func createQueryString(_ queryItems: QueryItems) -> String {
        let filteredQueryItems = queryItems.filter { !$0.value.isEmpty }
        guard !filteredQueryItems.isEmpty else { return .empty }
        
        return "?" +
            filteredQueryItems
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
    }
    
}

private extension NetworkService {
    
    func log(request: URLRequest, response: URLResponse?, data: Data?, error: Error?) {
        print("=======================================================")
        print("   ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓ ↓")
        print("URL:", request.url?.absoluteString ?? .empty)
        print("Method:", request.httpMethod ?? .empty)
        print("Headers:", request.allHTTPHeaderFields ?? String.empty)
        if let body = prettyString(request.httpBody) {
            print("HTTP Body:", body)
        }
        if let response = response as? HTTPURLResponse {
            print("Status:", response.statusCode)
        }
        if let responseJSON = prettyString(data) {
            print("Response:", responseJSON)
        }
        error.map { print("Error:", $0) }
        print("   ⬆===⬆===⬆===⬆===⬆===⬆===⬆===⬆===⬆===⬆===⬆")
        print("======================================================\n")
    }
    
    func prettyString(_ data: Data?) -> String? {
        if let data = data,
           let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
           let prettyData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
           let jsonString = String(data: prettyData, encoding: .utf8) {
            return jsonString
        } else {
            return nil
        }
    }
    
}
