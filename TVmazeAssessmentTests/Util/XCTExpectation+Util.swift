//
//  XCTExpectation+Util.swift
//  TVmazeAssessmentTests
//
//  Created by Otávio Zabaleta on 29/03/2024.
//

import XCTest

public extension XCTestCase {
    ///
    func blockExpectation(block: @escaping () -> Bool) -> XCTestExpectation {
        let evaluation: () -> Bool = { block() == true }
        return expectation(for: NSPredicate(format: "%@ == true", evaluation()), evaluatedWith: evaluation())
    }
}
