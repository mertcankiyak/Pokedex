//
//  NetworkManager.swift
//  Pokedex
//
//  Created by MERTCAN-KIYAK on 29.04.2024.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<T: Decodable>(endpoint: PokeEndpoint, completion: @escaping (Result<T, NetworkError>) -> Void)
}

class NetworkManager : NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    func request<T: Decodable>(endpoint: PokeEndpoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let myUrlRequest = try? endpoint.request() else {
            completion(.failure(.invalidURL))
            return}
        let task = URLSession.shared.dataTask(with: myUrlRequest) { data, response, error in
            if error != nil {
                completion(.failure(.connectionError))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
