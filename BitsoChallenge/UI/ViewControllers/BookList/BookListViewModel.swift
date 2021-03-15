//
//  BookListViewModel.swift
//  BitsoChallenge
//
//  Created by Junior Sancho on 3/13/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import Foundation

final class BookListViewModel {
    private(set) var availableBooks = [Book]()
    
    private let dispatchGroup = DispatchGroup()
    
    private let repository: NetworkRepositoryProtocol
    
    init(repository: NetworkRepositoryProtocol = NetworkRepository()) {
        self.repository = repository
    }

    func getAvailableBooks(completion: @escaping ([Book]) -> Void) {
        repository.availableBooks { [weak self] (result: Result<[Book], Error>) in
            switch result {
            case .success(let response):
                self?.availableBooks = response
                
                response.forEach { book in
                    self?.getBookDetails(bookSymbol: book.book)
                }
                
                self?.dispatchGroup.notify(queue: .main) {
                    completion(self?.availableBooks ?? [])
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getBookDetails(bookSymbol: String) {
        dispatchGroup.enter()
        repository.getBook(bookId: bookSymbol) { [weak self] (result: Result<Book, Error>) in
            switch result {
            case .success(let response):
                guard let bookIndex = self?.availableBooks.firstIndex(where: { $0.book == response.book }) else { break }
                self?.availableBooks[bookIndex] = response
            case .failure(let error):
                print("Error fetching book data \(bookSymbol): \(error.localizedDescription)")
            }
            self?.dispatchGroup.leave()
        }
    }
    
    func getBookData(_ index: IndexPath) -> Book {
        return availableBooks[index.row]
    }
}
