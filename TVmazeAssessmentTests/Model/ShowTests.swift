//
//  ShowTests.swift
//  TVmazeAssessmentTests
//
//  Created by Otávio Zabaleta on 27/03/2024.
//

import XCTest
@testable import TVmazeAssessment

final class ShowTests: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func testDecodeShow() throws {
        // GIVEN
        let show = JSONLoader.showSample()
        
        // THEN
        XCTAssertEqual(show.id, 1)
        XCTAssertEqual(show.name, "Under the Dome")
        XCTAssertEqual(show.images?.medium, "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg")
        XCTAssertEqual(show.images?.original, "https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg")
        XCTAssertEqual(show.genres, ["Drama", "Science-Fiction", "Thriller"])
        XCTAssertEqual(show.premiered, "2013-06-24")
        XCTAssertEqual(show.ended, "2015-09-10")
        XCTAssertEqual(show.schedule.days, ["Thursday"])
        XCTAssertEqual(show.schedule.time, "22:00")
        XCTAssertEqual(show.summary, "<p><b>Under the Dome</b> is the story of a small town that is suddenly and inexplicably sealed off from the rest of the world by an enormous transparent dome. The town's inhabitants must deal with surviving the post-apocalyptic conditions while searching for answers about the dome, where it came from and if and when it will go away.</p>")
        
    }
    
    func testDecodeListOfShows() throws {
        // GIVEN
        let showList = JSONLoader.showListSample()
        
        // THEN
        XCTAssertEqual(showList.count, 240)
        
        // WHEN
        let show5 = showList[4]

        // THEN
        XCTAssertEqual(show5.id, 5)
        XCTAssertEqual(show5.name, "True Detective")
        XCTAssertEqual(show5.images?.medium, "https://static.tvmaze.com/uploads/images/medium_portrait/490/1226764.jpg")
        XCTAssertEqual(show5.images?.original, "https://static.tvmaze.com/uploads/images/original_untouched/490/1226764.jpg")
        XCTAssertEqual(show5.schedule.time, "21:00")
        XCTAssertEqual(show5.schedule.days, ["Sunday"])
        XCTAssertEqual(show5.premiered, "2014-01-12")
        XCTAssertNil(show5.ended)
        XCTAssertEqual(show5.summary, "<p>Touch darkness and darkness touches you back. <b>True Detective</b> centers on troubled cops and the investigations that drive them to the edge. Each season features a new cast and a new case.</p><p><i><b>True Detective</b></i> is an American anthology crime drama television series created and written by Nic Pizzolatto. </p>")
        
        // WHEN
        let show240 = showList[239]
        
        // THEN
        XCTAssertEqual(show240.id, 249)
        XCTAssertEqual(show240.name, "The Daily Show with Jon Stewart")
        XCTAssertEqual(show240.images?.medium, "https://static.tvmaze.com/uploads/images/medium_portrait/327/818871.jpg")
        XCTAssertEqual(show240.images?.original, "https://static.tvmaze.com/uploads/images/original_untouched/327/818871.jpg")
        XCTAssertEqual(show240.schedule.time, "23:00")
        XCTAssertEqual(show240.schedule.days, ["Monday", "Tuesday", "Wednesday", "Thursday"])
        XCTAssertEqual(show240.premiered, "1999-01-11")
        XCTAssertEqual(show240.ended, "2015-08-06")
        XCTAssertEqual(show240.summary, "<p>One anchor, several correspondents, zero credibility.</p><p>If you're tired of the stodginess of the evening newscasts and you can't bear to sit through the spinmeisters and shills on the 24-hour cable news network, don't miss <b>The Daily Show with Jon Stewart</b>, the nightly half-hour series unburdened by objectivity, journalistic integrity or even accuracy.</p>")
    }
    
//    func testPerformanceExample() throws {
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
}
