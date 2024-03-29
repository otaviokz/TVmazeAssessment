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
        mockAPI.episodes = mockAPI.defaultEpisodes
        
        _ = blockExpectation {
            sut.seasons.count == 3 &&
            sut.seasons[0].episodes.count == 13 &&
            sut.seasons[0].number == 1 &&
            sut.seasons[1].number == 2 &&
            sut.seasons[2].number == 3 &&
            sut.seasons == mockAPI.defaultSeaons
        }
        
        // WHEN
        sut.fetchShowEpisodes(showId: 1)
        
        // THEN
        waitForExpectations(timeout: 10)
    }
    
    func makeSUT() -> (SeasonsAndEpisodesViewModel, MockTVmazeAPIClient) {
        let mockApiClient = MockTVmazeAPIClient()
        return (SeasonsAndEpisodesViewModel(api: mockApiClient), mockApiClient)
    }
}
