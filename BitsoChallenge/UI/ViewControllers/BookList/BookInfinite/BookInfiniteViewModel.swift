//
//  BookInfiniteViewModel.swift
//  BitsoChallenge
//
//  Created by Junior Sancho on 3/14/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import Foundation

class BookInfiniteViewModel {
    private var availableBooks = [Book]()
    
    var updateForm: (() -> Void)?
    
    var books: [Book] {
        set(newValue) {
            availableBooks = newValue
            updateForm?()
        }
        get {
            return availableBooks
        }
    }
    
    func getBookData(_ index: IndexPath) -> BookCellDataSource {
        return availableBooks[index.row]
    }
}
