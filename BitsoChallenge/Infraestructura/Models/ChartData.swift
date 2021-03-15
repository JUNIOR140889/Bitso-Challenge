//
//  ChartData.swift
//  BitsoChallenge
//
//  Created by Junior Sancho on 3/14/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import Foundation

struct ChartData {
    let low: Double
    let high: Double
    
    init(low: String?,
         high: String?) {
        self.low = Double(low ?? "") ?? 0
        self.high = Double(high ?? "") ?? 0
    }
}
