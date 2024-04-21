//
//  XCTExpectation+Util.swift
//  TVmazeAssessmentTests
//
//  Created by Otávio Zabaleta on 29/03/2024.
//

import XCTest

public extension XCTestCase {
    ///
//    func blockExpectation(block: @escaping () -> Bool, timeout: TimeInterval = 10) {//}-> XCTestExpectation {
////        let evaluation: () -> Bool = { block() == true }
//        let blockExpectation = expectation(description: "Block-based expectation")
//        let timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
//            DispatchQueue.main.async {
//                if block() {
//                    blockExpectation.fulfill()
//                }
//            }
//            self.wait(for: [blockExpectation], timeout: timeout)
//            timer.invalidate()
//        }
////        return expectation(for: NSPredicate(format: "%@ == true", evaluation()), evaluatedWith: evaluation)
//    }
    
    func blockExpectation(block: @escaping () -> Bool) -> XCTestExpectation {
        let evaluation: () -> Bool = { block() == true }
        return expectation(for: NSPredicate(format: "%@ == true", evaluation()), evaluatedWith: block)
    }
    
    func wait(timeout: TimeInterval = 10, for block: @escaping () -> Bool) {
        let blockExpectation = expectation(description: "Block-based expectation")
        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            DispatchQueue.main.async {
                if block() {
                    blockExpectation.fulfill()
                }
            }
            
        }
        wait(for: [blockExpectation], timeout: timeout)
        timer.invalidate()
    }
}
