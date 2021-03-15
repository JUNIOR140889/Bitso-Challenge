//
//  BookCellDataSource.swift
//  BitsoChallenge
//
//  Created by Junior Sancho on 3/13/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

protocol BookCellDataSource {
    var bookSymbol: String { get }
    var lastPrice: String { get }
}
