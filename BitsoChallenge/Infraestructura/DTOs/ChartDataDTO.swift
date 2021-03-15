//
//  ChartDataDTO.swift
//  BitsoChallenge
//
//  Created by Junior Sancho on 3/14/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import Foundation

struct ChartDataDTO: Codable {
    let date: String?
    let dated: String?
    let value: String?
    let volume: String?
    let open: String?
    let low: String?
    let high: String?
    let close: String?
    let vwap: String?
    
    func toChartData() -> ChartData {
        return ChartData(low: low,
                         high: high)
    }
}
