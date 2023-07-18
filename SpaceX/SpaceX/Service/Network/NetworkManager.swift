//
//  NetworkManager.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import UIKit

protocol NetworkManagerProtocol {
    func request<T: Decodable>(fromURL url: URL,
                               httpMethod: HttpMethod,
                               completion: @escaping (Result<T, NetworkError>) -> Void)
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void)
}

final class NetworkManager {
    
    // MARK: - Properties
    static let shared = NetworkManager()
    private let session: URLSession = .shared
    let cache = NSCache<NSString, UIImage>()
    
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
        
        let task = session.dataTask(with: request) { data, queryResponse, error in
            
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
        
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(UIImage(named: "noImageAvailable"))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data),
                  error == nil
            else {
                completed(UIImage(named: "noImageAvailable"))
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}
