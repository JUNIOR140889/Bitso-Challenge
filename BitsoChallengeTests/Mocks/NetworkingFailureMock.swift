//
//  NetworkingFailureMock.swift
//  BitsoChallengeTests
//
//  Created by Junior Sancho on 3/14/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import Foundation
@testable import BitsoChallenge

class NetworkingFailureMock: NetworkingServiceProtocol {
    func doRequest<T>(targetType: TargetType, completion: @escaping (Result<T, Error>) -> Void) where T: Codable {
        completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
    }
}
