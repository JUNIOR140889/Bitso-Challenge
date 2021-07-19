//
//  NetworkingService.swift
//  BitsoChallenge
//
//  Created by Junior Sancho on 3/12/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import Foundation

// MARK: - Capa de abstraccion, desacople y mocks en los test.

protocol NetworkingServiceProtocol {
     func doRequest<T>(targetType: TargetType,
                         completion: @escaping (Result<T, Error>) -> Void) where T: Codable
}

// MARK: - URLSession
/**
 URLSession
 Objeto responsable de enviar y recibir requests. La configuración puede ser de 3 tipos:
 - Default: Almacenamiento global en el disco de cache, credenciales y cookies.
 - Ephemeral: Lo mismo que default pero se almacena en memoria. Es como una sesión privada
 - Background: Permite subir y bajar archivos en background incluso si la app no esta corriendo

 Shared
 No se le puede asignar un delegado ni una configuración, tiene limitaciones
 - No se pueden subir ni bajar archivos en background mientras la app no esta corriendo
 - Si usas caches, cookies, autenticación.. mejor usar default en vez de shared
 */

class NetworkingService: NetworkingServiceProtocol {
    func doRequest<T>(targetType: TargetType,
                      completion: @escaping (Result<T, Error>) -> Void) where T: Codable {
        var urlComponents = URLComponents(string: targetType.baseURL + targetType.path)
        
        if let params = targetType.parameters {
            let queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value as? String) }
            urlComponents?.queryItems = queryItems
        }

        guard let url = urlComponents?.url else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = targetType.method.rawValue
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            var result: Result<T, Error> = .failure(ErrorsType.invalidResponse)
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            if let error = error {
                result = .failure(ErrorsType.invalidParse(error.localizedDescription))
                return
            }
            
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let decodeData = try JSONDecoder().decode(T.self, from: data)
                    result = .success(decodeData)
                } catch let parseError {
                    result = .failure(ErrorsType.invalidParse(parseError.localizedDescription))
                }
            } else {
                result = .failure(ErrorsType.invalidResponse)
            }
            
        }.resume()
    }
}
// MARK: - Mejoras: Soporte parametros por body(TargetType), usar URLRequest para manejar multiples methods(Get, Post, ect), manejo de errores con un enum de codigos.

enum ErrorsType: Swift.Error {
    case invalidParse(String)
    case invalidResponse
    case noInternet
    var userMessage: String {
        switch self {
        case .invalidResponse:
            return "Error response"
        case .noInternet:
            return "No hay conexion de internet"
        case .invalidParse(let response):
            return "Error parse" + response
        }
    }
}
