//
//  GetBookNetworkingMock.swift
//  BitsoChallengeTests
//
//  Created by Junior Sancho on 3/14/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import Foundation
@testable import BitsoChallenge

class BookNetworkingMock: NetworkingServiceProtocol {
    let bundle = Bundle(for: BookNetworkingMock.self)

    func doRequest<T>(targetType: TargetType, completion: @escaping (Result<T, Error>) -> Void) where T: Codable {
        if let path = bundle.path(forResource: "Book", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
            do {
                let availableBooks = try JSONDecoder().decode(T.self, from: data)
                completion(.success(availableBooks))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
