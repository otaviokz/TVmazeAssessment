//
//  PagedShowsViewModelTests.swift
//  TVmazeAssessmentTests
//
//  Created by Otávio Zabaleta on 29/03/2024.
//

import XCTest
@testable import TVmazeAssessment

final class PagedShowsViewModelTests: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func testFetchShowsPagedShows() throws {
        // GIVEN
        let (sut, _) = makeSUT()
        
        // THEN
        XCTAssertEqual(sut.shows, [])
        XCTAssertEqual(sut.isLoading, false)
        XCTAssertEqual(sut.showErrorMessage, false)
        XCTAssertEqual(sut.errorMessage, "")
        
        // GIVEN
        
        
        // WHEN
        sut.onViewAppear()

        wait() {
            sut.isLoading == false &&
            sut.shows == JSONLoader.showSearchSamplePage0()
        }
        
        sut.previousPage(num: 1)
        
        // GIVEN
        wait() {
            sut.shows == JSONLoader.showSearchSamplePage0()
        }
        
        // WHEN
        sut.nextPage(num: 1)
        
        wait() {
            sut.shows == JSONLoader.showSearchSamplePage1()
        }
    }

    func makeSUT() -> (PagedShowsViewModel, MockTVmazeAPIClient) {
        let mockApiClient = MockTVmazeAPIClient()
        return (PagedShowsViewModel(api: mockApiClient), mockApiClient)
    }
    
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
