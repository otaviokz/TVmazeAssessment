//
//  SeasonTests.swift
//  TVmazeAssessmentTests
//
//  Created by Otávio Zabaleta on 28/03/2024.
//

import XCTest
@testable import TVmazeAssessment

final class SeasonTests: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func testParseSeasonsAndEpisodes() throws {
        // GIVEN
        let episodes = JSONLoader.showEpisodesSample()
        
        // WHEN
        let seasons = episodes.seasons
        let s01 = seasons[0]
        let s03 = seasons[2]
        
        // THEN
        XCTAssertEqual(seasons.count, 3)
        
        XCTAssertEqual(s01.number, 1)
        XCTAssertEqual(s01.episodes.count, 13)
        for episode in s01.episodes {
            XCTAssertEqual(episode.seasonNumber, 1)
        }
        XCTAssertEqual(s01.episodes[0].name, "Pilot")
        XCTAssertEqual(s01.episodes[12].name, "Curtains")
        
        XCTAssertEqual(s03.number, 3)
        XCTAssertEqual(s03.episodes.count, 13)
        for episode in s03.episodes {
            XCTAssertEqual(episode.seasonNumber, 3)
        }
        XCTAssertEqual(s03.episodes[0].name, "Move On")
        XCTAssertEqual(s03.episodes[12].name, "The Enemy Within")
        XCTAssertEqual(s03.number, 3)
        
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
