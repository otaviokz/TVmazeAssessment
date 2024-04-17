//
//  ShowEpisodeTests.swift
//  TVmazeAssessmentTests
//
//  Created by Otávio Zabaleta on 27/03/2024.
//

import XCTest
@testable import TVmazeAssessment

final class EpisodeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodeEpisodes() throws {
        // GIVEN
        let episodes = JSONLoader.showEpisodesSample()
        
        // THEN
        XCTAssertEqual(episodes.count, 39)
        
        // WHEN
        let e04s01 = episodes[3]
        XCTAssertEqual(e04s01.id, 4)
        XCTAssertEqual(e04s01.name, "Outbreak")
        XCTAssertEqual(e04s01.number, 4)
        XCTAssertEqual(e04s01.seasonNumber, 1)
        XCTAssertEqual(e04s01.seasonNumber, 1)
        XCTAssertEqual(e04s01.images?.medium, "https://static.tvmaze.com/uploads/images/medium_landscape/1/4391.jpg")
        XCTAssertEqual(e04s01.images?.original, "https://static.tvmaze.com/uploads/images/original_untouched/1/4391.jpg")
        XCTAssertEqual(e04s01.summary, "<p>The people of Chester's Mill fall into a state of panic as an outbreak of meningitis strikes their community, threatening their already depleted medical supplies. Meanwhile, Julia continues to search for answers into her husband's disappearance.</p>")
        
        let e13s03 = episodes[38]
        XCTAssertEqual(e13s03.id, 185054)
        XCTAssertEqual(e13s03.name, "The Enemy Within")
        XCTAssertEqual(e13s03.number, 13)
        XCTAssertEqual(e13s03.seasonNumber, 3)
        XCTAssertEqual(e13s03.images?.medium, "https://static.tvmaze.com/uploads/images/medium_landscape/17/43622.jpg")
        XCTAssertEqual(e13s03.images?.original, "https://static.tvmaze.com/uploads/images/original_untouched/17/43622.jpg")
        XCTAssertEqual(e13s03.summary,
                       "<p>As the Dome in Chester's Mill comes down, the Resistance makes a final attempt to protect the outside world from the infected townspeople in the Kinship and their new queen.</p>")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
