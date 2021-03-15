//
//  BookDetailViewModel.swift
//  BitsoChallenge
//
//  Created by Junior Sancho on 3/13/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import Foundation
import AAInfographics

enum ChartDataTime: Int {
    case oneMonth
    case threeMonths
    case oneYear 
    
    var path: String {
        switch self {
        case .oneMonth:
            return "1month"
        case .threeMonths:
            return "3months"
        case .oneYear:
            return "1year"
        }
    }
}

final class BookDetailViewModel {
    let book: Book
    let repository: NetworkRepositoryProtocol
    
    init(book: Book, repository: NetworkRepositoryProtocol = NetworkRepository()) {
        self.book = book
        self.repository = repository
    }
    
    func getChartData(_ time: ChartDataTime, completion: @escaping (AAChartModel?) -> Void) {
        repository.getChartData(bookId: book.book, chartTime: time) { [weak self] result in
            switch result {
            case .success(let chartData):
                let chartModel = self?.getChartModel(lowestPrices: chartData.map({ $0.low }),
                                                     highestPrices: chartData.map({ $0.high }))
                completion(chartModel)
            case .failure(let error):
                print("Error fetching chart data: \(error)")
                completion(nil)
            }
        }
    }
    
    // MARK: - Private
    private func getChartModel(lowestPrices: [Double], highestPrices: [Double]) -> AAChartModel {
        let aaChartModel = AAChartModel()
        .chartType(.line)
        .animationType(.bounce)
        .dataLabelsEnabled(false)
        .colorsTheme(["#EA4E3D","#64C265"])
        .backgroundColor("#1C1C1E")
        .axesTextColor("#BCBABC")
        .series([
            AASeriesElement()
                .name("Lowest Price")
                .data(lowestPrices),
            AASeriesElement()
                .name("Highest Price")
                .data(highestPrices),
        ])
        return aaChartModel
    }
}
