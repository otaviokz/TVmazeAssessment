//
//  SeasonsAndEpisodesViewModelTests.swift
//  TVmazeAssessmentTests
//
//  Created by Otávio Zabaleta on 29/03/2024.
//

import XCTest
@testable import TVmazeAssessment

final class SeasonsAndEpisodesViewModelTests: XCTestCase {
    
    override func setUpWithError() throws { }
    
    override func tearDownWithError() throws { }
    
    func testFetchEpisodesAndSeasons() throws {
        // GIVEN
        let (sut, mockAPI) = makeSUT()
        
        // WHEN
        sut.fetchShowEpisodes(showId: 1)
        
        // THEN
        wait() {
            sut.isLoading == true &&
            sut.seasons.isEmpty
        }
        
        // WHEN
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            mockAPI.episodes = mockAPI.defaultEpisodes
        }
        
        // THEN
        wait() {
            sut.seasons.count == 3 &&
            sut.seasons[0].episodes.count == 13 &&
            sut.seasons[0].number == 1 &&
            sut.seasons[1].number == 2 &&
            sut.seasons[2].number == 3 &&
            sut.seasons == mockAPI.defaultSeaons
        }
    }
    
    func makeSUT() -> (SeasonsAndEpisodesViewModel, MockTVmazeAPIClient) {
        let mockApiClient = MockTVmazeAPIClient()
        return (SeasonsAndEpisodesViewModel(api: mockApiClient), mockApiClient)
    }
}
