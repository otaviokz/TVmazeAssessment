//
//  HTTPClient.swift
//  TVmazeAssessment
//
//  Created by Otávio Zabaleta on 27/03/2024.
//

import Foundation

public protocol HTTPClientType {
    func get<T: Decodable>(_ url: URL, headers httpHeaders: [String: String]?) async throws -> T
    func postJSON<T: Decodable>(_ url: URL, body: Data, httpHeaders: [String: String]?) async throws -> T
}

public struct HTTPClient: HTTPClientType {
    public static let shared = HTTPClient()
    
    private init() {}
    
    public func get<T: Decodable>(_ url: URL, headers httpHeaders: [String: String]?) async throws -> T {
        try await connect(.get(url).headers(httpHeaders))
        
    }
    
    public func postJSON<T: Decodable>(_ url: URL, body: Data, httpHeaders: [String: String]?) async throws -> T {
        try await connect(.postJSON(body, to: url).headers(httpHeaders))
    }
}

private extension HTTPClient {
    func connect<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, rulResponse) = try await URLSession.shared.data(for: request)
        if let httpUrlResponse = rulResponse as? HTTPURLResponse {
            guard httpUrlResponse.statusCode == 200 else {
                throw  HTTPClientError.http(code: httpUrlResponse.statusCode)
            }
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print(data)
            throw HTTPClientError.decode(error)
        }
    }
}
