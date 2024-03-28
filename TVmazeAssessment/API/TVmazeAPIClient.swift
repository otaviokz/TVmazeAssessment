//
//  TVmazeAPIClient.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 27/03/2024.
//

import Foundation

protocol TVmazeAPIClientType {
    func searchSeries(query: String) async throws -> [Show]
}

class TVmazeAPIClient: TVmazeAPIClientType {
    private let apiKey = "3Xjssgcr6q2W4MKfGhQ5Ut8tqwegAtjj"
    private let baseURL = "https://api.tvmaze.com"
    private let httpClient: HTTPClientType
    
    init(httpClient: HTTPClientType = HTTPClient.shared) {
        self.httpClient = httpClient
    }
}

extension TVmazeAPIClient {
    private var searchEndpoint: String { "search/shows" }
    
    func searchSeries(query: String) async throws -> [Show] {
        guard var searchURL = URL(string: baseURL) else {
            fatalError("baseURL must produce an URL")
        }
        searchURL.append(path: searchEndpoint)
        return try await httpClient.get(searchURL, headers: ["q": query, "apiKey": apiKey])
    }
}

extension TVmazeAPIClient {
    private var showsEndpoint: String { "shows" }
    
    func fetchShows() async throws -> [Show] {
        guard var showsURL = URL(string: baseURL) else {
            fatalError("baseURL must produce an URL")
        }
        showsURL.append(path: showsEndpoint)
        return try await httpClient.get(showsURL, headers: ["apiKey": apiKey])
    }
    
}
