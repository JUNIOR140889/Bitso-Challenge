//
//  NetworkingService.swift
//  BitsoChallenge
//
//  Created by Junior Sancho on 3/12/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import Foundation

protocol NetworkingServiceProtocol {
     func doRequest<T>(targetType: TargetType,
                         completion: @escaping (Result<T, Error>) -> Void) where T: Codable
}

class NetworkingService: NetworkingServiceProtocol {
    func doRequest<T>(targetType: TargetType,
                      completion: @escaping (Result<T, Error>) -> Void) where T: Codable {
        var urlComponents = URLComponents(string: targetType.baseURL + targetType.path)
        
        if let params = targetType.parameters {
            let queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value as? String) }
            urlComponents?.queryItems = queryItems
        }
    
        guard let url = urlComponents?.url else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            var result: Result<T, Error> = .failure(NSError(domain: "", code: 0, userInfo: nil))
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            if let error = error {
                result = .failure(error)
                return
            }
            
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let decodeData = try JSONDecoder().decode(T.self, from: data)
                    result = .success(decodeData)
                } catch let parseError {
                    result = .failure(parseError)
                }
            }
        }.resume()
    }
}
