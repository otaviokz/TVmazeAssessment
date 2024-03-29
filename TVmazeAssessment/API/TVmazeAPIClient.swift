//
//  TVmazeAPIClient.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 27/03/2024.
//

import Foundation

enum TVmazeAPIClientError: Error {
    case http(Error)
    case unknown
}

protocol TVmazeAPIClientType {
    func searchShows(query: String) async throws -> [Show]
    func fetchEpisodes(showId: Int) async throws -> [Episode]
}

class TVmazeAPIClient: TVmazeAPIClientType {
  
    
    static var shared = TVmazeAPIClient()
    private let apiKey = "3Xjssgcr6q2W4MKfGhQ5Ut8tqwegAtjj"
    private let baseURL = "https://api.tvmaze.com"
    private let httpClient: HTTPClientType
    
    init(httpClient: HTTPClientType = HTTPClient.shared) {
        self.httpClient = httpClient
    }
    
    private var searchEndpoint: String { "search/shows" }
    func searchShows(query: String) async throws -> [Show] {
        guard var baseUrl = URL(string: baseURL) else {
            fatalError("baseURL must produce an URL")
        }
        baseUrl.append(path: searchEndpoint)
        baseUrl.append(queryItems: [URLQueryItem(name: "q", value: query)])
        do {
            let containers: [ShowContainer] = try await httpClient
                .get(baseUrl, headers: ["apiKey": apiKey])
            return containers.map { $0.show }
        } catch {
            throw TVmazeAPIClientError.http(error)
        }
    }
    
    func fetchEpisodes(showId: Int) async throws -> [Episode] {
        guard var baseUrl = URL(string: baseURL) else {
            fatalError("baseURL must produce an URL")
        }
        
        baseUrl.append(path: "shows/\(showId)/episodes")
        do {
            return try await httpClient
                .get(baseUrl, headers: ["apiKey": apiKey])
        } catch {
            throw TVmazeAPIClientError.http(error)
        }
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
