//
//  NetworkError.swift
//  SpaceX
//
//  Created by Alexander Vagin on 07.07.2023.
//

import Foundation

// MARK: - NetworkError
enum NetworkError: Error {
    case invalidResponse
    case invalidRequestBody
    case invalidStatusCode(Int)
    case invalidDecoding
    case invalidURL
    case invalidSession(Error)
    
    var message: String {
        switch self {
        case .invalidResponse:
            return "Нет ответа от сервера"
        case .invalidRequestBody:
            return "Некорректное тело запроса"
        case .invalidStatusCode(let code):
            return "Status code от сервера: \(code)"
        case .invalidDecoding:
            return "Невозможно декодировать"
        case .invalidURL:
            return "Некорректный URL"
        case .invalidSession(let error):
            return "Ошибка сессии: \(error)"
        }
    }
}
