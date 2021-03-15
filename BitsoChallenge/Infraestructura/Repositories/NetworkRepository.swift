//
//  NetworkRepository.swift
//  BitsoChallenge
//
//  Created by Junior Sancho on 3/12/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

protocol NetworkRepositoryProtocol {
    func availableBooks(completion: @escaping (Result<[Book], Error>) -> Void)
    func getBook(bookId: String, completion: @escaping (Result<Book, Error>) -> Void)
    func getChartData(bookId: String, chartTime: ChartDataTime, completion: @escaping (Result<[ChartData], Error>) -> Void)
}

class NetworkRepository: NetworkRepositoryProtocol {
    private let provider: NetworkingServiceProtocol 
    
    init(provider: NetworkingServiceProtocol = NetworkingService()) {
        self.provider = provider
    }
    
    func availableBooks(completion: @escaping (Result<[Book], Error>) -> Void) {
        provider.doRequest(targetType: MainApi.availableBooks) { (result: Result<AvailableBooksDTO, Error>) in
            switch result {
            case .success(let response):
                let books = response.payload?.compactMap({ $0.toBook() })
                completion(.success(books ?? [Book]()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getBook(bookId: String, completion: @escaping (Result<Book, Error>) -> Void) {
        provider.doRequest(targetType: MainApi.getBook(bookId: bookId)) { (result: Result<BookDTO, Error>) in
            switch result {
            case .success(let response):
                let book = response.toBook()
                completion(.success(book))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getChartData(bookId: String, chartTime: ChartDataTime, completion: @escaping (Result<[ChartData], Error>) -> Void) {
        provider.doRequest(targetType: MainApi.chartData(bookId: bookId, chartTime: chartTime)) { (result: Result<[ChartDataDTO], Error>) in
            switch result {
            case .success(let response):
                let chartData = response.compactMap({ $0.toChartData() })
                completion(.success(chartData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
