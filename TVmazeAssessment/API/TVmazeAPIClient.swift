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
    func fetchShows(page: Int) async throws -> [Show]
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
        baseUrl.append(queryItems: [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "apiKey", value: apiKey)
        ])
        do {
            let containers: [ShowContainer] = try await httpClient
                .get(baseUrl, headers: nil/*["apiKey": apiKey]*/)
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
        baseUrl.append(queryItems: [URLQueryItem(name: "apiKey", value: apiKey)])
        do {
            return try await httpClient
                .get(baseUrl, headers: nil/*["apiKey": apiKey]*/)
        } catch {
            throw TVmazeAPIClientError.http(error)
        }
    }
    
    func fetchShows(page: Int) async throws -> [Show] {
        guard var baseUrl = URL(string: baseURL) else {
            fatalError("baseURL must produce an URL")
        }
        baseUrl.append(path: "shows")
        baseUrl.append(queryItems: [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ])
        do {
            return try await httpClient
                .get(baseUrl, headers: nil/*["apiKey": apiKey]*/)
        } catch {
            throw TVmazeAPIClientError.http(error)
        }
    }
}
