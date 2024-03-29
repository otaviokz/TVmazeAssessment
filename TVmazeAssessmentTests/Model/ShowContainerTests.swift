//
//  ShowContainer.swift
//  TVmazeAssessmentTests
//
//  Created by Otávio Zabaleta on 28/03/2024.
//

import XCTest
@testable import TVmazeAssessment

final class ShowContainerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodeShows() throws {
        // GIVEN
        let searchResultShows = JSONLoader.showSearchContainerSample().map { $0.show }
        
        
        // THEN
        XCTAssertEqual(searchResultShows.count, 7)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
