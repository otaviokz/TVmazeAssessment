//
//  MockAPIClient.swift
//  TVmazeAssessmentTests
//
//  Created by Otávio Zabaleta on 29/03/2024.
//

import Foundation
@testable import TVmazeAssessment

class MockTVmazeAPIClient: TVmazeAPIClientType {
    var episodes: [Episode] = []
    func fetchEpisodes(showId: Int) async throws -> [Episode] {
        return episodes
    }
    let defaultEpisodes = JSONLoader.showEpisodesSample()
    let defaultSeaons = JSONLoader.showEpisodesSample().seasons
    
    var shows: [Show] = []
    var error: TVmazeAPIClientError?
    func searchShows(query: String) async throws -> [Show] {
        while true {
            if let error = error {
                throw error
            } else if !shows.isEmpty {
                return shows
            }
            sleep(1)
        }
    }
    
    func fetchShows(page: Int) async throws -> [Show] {
        page == 0 ? JSONLoader.showSearchSamplePage0() : JSONLoader.showSearchSamplePage1()
    }
    
    
    let defaultShows = JSONLoader.showSearchSample()
}
