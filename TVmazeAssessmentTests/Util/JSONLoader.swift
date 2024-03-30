//
//  JSONLoader.swift
//  TVmazeAssessmentTests
//
//  Created by Otávio Zabaleta on 27/03/2024.
//

import Foundation
@testable import TVmazeAssessment

class JSONLoader {
    static func loadJson<T: Decodable>(_ filename: String) throws -> T {
        guard let file = Bundle(for: Self.self).url(forResource: filename, withExtension: "json") else {
            fatalError("Couldn't find \(filename) in test bundle.")
        }
        
        return try JSONDecoder().decode(T.self, from: try Data(contentsOf: file))
    }
    
    static func showSample() -> Show {
        loadDecodedJson("SampleShow")
    }
    
    static func showListSample() -> [Show] {
        loadDecodedJson("SampleShowList")
    }
    
    static func showEpisodesSample() -> [Episode] {
        loadDecodedJson("ShowEpisodesSample")
    }
    
    static func showSearchContainerSample() -> [ShowContainer] {
        loadDecodedJson("SampleShowSearchResponse")
    }
    
    static func showSearchSample() -> [Show] {
        let conatiners: [ShowContainer] = loadDecodedJson("SampleShowSearchResponse")
        return conatiners.map { $0.show }
    }
    
    
    static func showSearchSamplePage0() -> [Show] {
        loadDecodedJson("SampleShowsPage0")
    }
    
    static func showSearchSamplePage1() -> [Show] {
        loadDecodedJson("SampleShowsPage1")
    }
    
    private static func loadDecodedJson<T: Decodable>(_ fileName: String) -> T {
        var result: T
        do {
            result = try loadJson(fileName)
        } catch {
            print(error.localizedDescription)
            fatalError()
        }
        return result
    }
}

