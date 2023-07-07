//
//  NetworkManager.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<T: Decodable>(fromURL url: URL,
                               httpMethod: HttpMethod,
                               completion: @escaping (Result<T, NetworkError>) -> Void)
}

final class NetworkManager {
    
    // MARK: - Properties
    static let shared = NetworkManager()
    private let session: URLSession = .shared
    
    // MARK: - Init
    private init() {}
}

extension NetworkManager: NetworkManagerProtocol {
    
    func request<T: Decodable>(fromURL url: URL,
                               httpMethod: HttpMethod = .get,
                               completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        let completionOnMain: (Result<T, NetworkError>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.method
        
        let query = session.dataTask(with: request) { data, queryResponse, error in
            
            if let error = error {
                completionOnMain(.failure(.invalidSession(error)))
                return
            }
            
            guard let response = queryResponse as? HTTPURLResponse else {
                return completionOnMain(.failure(.invalidResponse))
            }
            if !(200..<300).contains(response.statusCode) {
                return completionOnMain(.failure(.invalidStatusCode(response.statusCode)))
            }
            
            guard let data = data else { return }
            do {
                let parse = try JSONDecoder().decode(T.self, from: data)
                completionOnMain(.success(parse))
            } catch {
                debugPrint("Не удалось преобразовать данные в запрошенный тип. Причина: \(error.localizedDescription)")
                completionOnMain(.failure(.invalidDecoding))
            }
        }
        
        query.resume()
    }
}
