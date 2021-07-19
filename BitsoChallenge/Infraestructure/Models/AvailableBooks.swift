//
//  AvailableBooks.swift
//  BitsoChallenge
//
//  Created by Junior Sancho on 3/14/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import Foundation

struct AvailableBook {
    let books: [Book]
    
    init(books: [Book]) {
        self.books = books
    }
}

struct Book {
    let book: String
    var bookDetails: BookDetails?
    
    init(book: String?,
         bookDetails: BookDetails? = nil) {
        self.book = book ?? ""
        self.bookDetails = bookDetails
    }
}

extension Book: BookCellDataSource {
    var bookSymbol: String {
        return book
    }
    
    var lastPrice: String {
        return bookDetails?.last ?? ""
    }
}

struct BookDetails {
    let last: String
    let bid: String
    let ask: String
    let low: String
    let high: String
    let volume: String
    
    var spread: String = ""
    
    init(last: String?,
         bid: String?,
         ask: String?,
         low: String?,
         high: String?,
         volume: String?) {
        self.last = last ?? ""
        self.bid = bid ?? ""
        self.ask = ask ?? ""
        self.low = low ?? ""
        self.high = high ?? ""
        self.volume = volume ?? ""
        
        if let bidPrice = Double(bid ?? ""), let askPrice = Double(ask ?? "") {
            let difference = abs(bidPrice) - abs(askPrice)
            let maxPrice = max(bidPrice, askPrice)
            let spread = difference * 100 / maxPrice
            self.spread = "\(spread) %"
        }
    }
}
