//
//  BitsoChallengeTests.swift
//  BitsoChallengeTests
//
//  Created by Junior Sancho on 3/12/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import XCTest
@testable import BitsoChallenge

class BitsoChallengeIntegrationTests: XCTestCase {
    let repository = NetworkRepository()

    func testIntegrationAvailableBooks() {
        let expectation = XCTestExpectation(description: "Get Available Books")

        repository.availableBooks { result in
            switch result {
            case .success(_):
                expectation.fulfill()
            case .failure(_):
                XCTFail("Should be success")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }

    func testIntegrationGetBook() {
        let expectation = XCTestExpectation(description: "Get Book with symbol btc_dai")

        repository.getBook(bookId: "btc_dai") { result in
            switch result {
            case .success(_):
                expectation.fulfill()
            case .failure(_):
                XCTFail("Should be success")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testIntegrationGetChartData() {
        let expectation = XCTestExpectation(description: "Get chart with symbol btc_dai")

        repository.getChartData(bookId: "btc_dai", chartTime: .oneMonth) { result in
            switch result {
            case .success(_):
                expectation.fulfill()
            case .failure(_):
                XCTFail("Should be success")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
}
