//
//  RepositoryTests.swift
//  BitsoChallengeTests
//
//  Created by Junior Sancho on 3/14/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import XCTest
@testable import BitsoChallenge

class RepositoryTests: XCTestCase {
    func testAvailableBooks() {
        let expectation = XCTestExpectation(description: "Get Available Books")
        let repository = NetworkRepository(provider: AvailableBooksNetworkingMock())

        repository.availableBooks { result in
            switch result {
            case .success(let books):
                XCTAssertEqual(books.count, 2)
                XCTAssertEqual(books[0].book, "btc_mxn")
                XCTAssertEqual(books[1].book, "eth_mxn")
                expectation.fulfill()
            case .failure:
                XCTFail("Should be success")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10)

    }

    func testAvailableBooksFailure() {
        let expectation = XCTestExpectation(description: "Get Available Books")
        let repository = NetworkRepository(provider: NetworkingFailureMock())

        repository.availableBooks { result in
            switch result {
            case .success:
                XCTFail("Should be failure")
                expectation.fulfill()
            case .failure:
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10)

    }
    
    func testGetBook() {
        let expectation = XCTestExpectation(description: "Get Book btc_mxn")
        let repository = NetworkRepository(provider: BookNetworkingMock())

        repository.getBook(bookId: "btc_mxn") { result in
            switch result {
            case .success(let book):
                XCTAssertEqual(book.book, "btc_mxn")
                XCTAssertNotNil(book.bookDetails)
                expectation.fulfill()
            case .failure:
                XCTFail("Should be success")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 10)

    }

    func testGetBookFailure() {
        let expectation = XCTestExpectation(description: "Get Available Books")
        let repository = NetworkRepository(provider: NetworkingFailureMock())

        repository.getBook(bookId: "btc_mxn") { result in
            switch result {
            case .success:
                XCTFail("Should be failure")
                expectation.fulfill()
            case .failure:
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 10)

    }

    func testGetChartData() {
        let expectation = XCTestExpectation(description: "Get chart btc_mxn")
        let repository = NetworkRepository(provider: ChartNetworkingMock())

        repository.getChartData(bookId: "btc_mxn", chartTime: .oneMonth) { result in
            switch result {
            case .success(let chartData):
                XCTAssertEqual(chartData.count, 3)
                expectation.fulfill()
            case .failure:
                XCTFail("Should be success")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 10)

    }

    func testGetChartDataFailure() {
        let expectation = XCTestExpectation(description: "Get chart btc_mxn")
        let repository = NetworkRepository(provider: NetworkingFailureMock())

        repository.getChartData(bookId: "btc_mxn", chartTime: .oneMonth) { result in
            switch result {
            case .success:
                XCTFail("Should be failure")
                expectation.fulfill()
            case .failure:
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 10)

    }
}
