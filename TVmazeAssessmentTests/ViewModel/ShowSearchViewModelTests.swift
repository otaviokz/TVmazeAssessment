//
//  ShowSearchViewModelTests.swift
//  TVmazeAssessmentTests
//
//  Created by Otávio Zabaleta on 28/03/2024.
//

import XCTest
@testable import TVmazeAssessment

final class ShowSearchViewModelTests: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func testFetchShows_HappyPath() throws {
        // GIVEN
        let (sut, mockAPI) = makeSUT()
        
        // THEN
        XCTAssertEqual(sut.shows, [])
        XCTAssertEqual(sut.isLoading, false)
        XCTAssertEqual(sut.showErrorMessage, false)
        XCTAssertEqual(sut.errorMessage, "")

        // WHEN
        sut.searchText = "The"
        
        _ = blockExpectation {
            sut.isLoading == true &&
            sut.shows == []
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + ShowSearchViewModel.searchDelay) {
            mockAPI.shows = mockAPI.defaultShows
        }
        
        _ = blockExpectation {
            sut.shows == mockAPI.defaultShows &&
            sut.isLoading == false
        }
        
        waitForExpectations(timeout: 5)
    }

    func testFetchShows_HttpError() {
        // GIVEN
        let (sut, mockAPI) = makeSUT()
        
        // THEN
        XCTAssertEqual(sut.shows, [])
        XCTAssertEqual(sut.isLoading, false)
        XCTAssertEqual(sut.showErrorMessage, false)
        XCTAssertEqual(sut.errorMessage, "")
        
        // GIVEN
        mockAPI.error = TVmazeAPIClientError.unknown
        
        // WHEN
        sut.searchText = "The"
        
        // THEN
        _ = blockExpectation {
            sut.isLoading == false &&
            sut.shows == [] &&
            sut.showErrorMessage == true &&
            sut.errorMessage == "Unable to search for 'The', please try again later."
        }
        
        waitForExpectations(timeout: 5)
    }
    
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

    func makeSUT() -> (ShowSearchViewModel, MockTVmazeAPIClient) {
        let mockApiClient = MockTVmazeAPIClient()
        return (ShowSearchViewModel(api: mockApiClient), mockApiClient)
    }
}
