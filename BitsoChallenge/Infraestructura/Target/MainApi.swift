//
//  MainApp.swift
//  BitsoChallenge
//
//  Created by Junior Sancho on 3/12/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//
import Foundation

enum MainApi {
    case availableBooks
    case getBook(bookId: String)
    case chartData(bookId: String, chartTime: ChartDataTime)
}

extension MainApi: TargetType {
    var baseURL: String {
        switch self {
        case .chartData:
            return Paths.baseURL
        default:
            return Paths.baseURLv3
        }
    }
    
    var path: String {
        switch self {
        case .availableBooks:
            return Paths.availableBooks
        case .getBook:
            return Paths.getBook
        case .chartData(let bookId, let chartTime):
            return String(format: Paths.chart, bookId, chartTime.path)
        }
    }

    var parameters: [String : Any]? {
        switch self {
        case .availableBooks, .chartData:
            return nil
        case .getBook(let bookId):
            return ["book": bookId]
        }
    }

    var method: HTTPMethod {
        return .get
    }
}
