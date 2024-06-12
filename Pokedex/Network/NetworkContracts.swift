//
//  NetworkContracts.swift
//  Pokedex
//
//  Created by MERTCAN-KIYAK on 29.04.2024.
//

import Foundation

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var body: Encodable? { get }
    var queryItems: [URLQueryItem]? { get }
    func request() throws -> URLRequest
    func pokeApiURL() -> String
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum PokeEndpoint: Endpoint {
    
    case getAllPokemon
    
    var baseUrl: String{
        return "https://pokedex-bb36f.firebaseio.com/";
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getAllPokemon:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .getAllPokemon:
            return "pokemon.json"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAllPokemon:
            return .get
        }
    }
    
    var body: Encodable?  {
        switch self {
        case .getAllPokemon:
            return nil
        }
    }
    
    var queryParameters: [String: String]? {
        switch self {
        case .getAllPokemon:
            return nil
        }
    }
    
    func pokeApiURL() -> String {
        return "\(self.baseUrl)\(path)"
    }
    
    
    func request() throws -> URLRequest {
        guard var urlComponents =  URLComponents(string: pokeApiURL()) else {   throw NetworkError.connectionError }
        guard let url = urlComponents.url else { throw NetworkError.invalidURL }
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let body = body {
            request.httpBody = try?  JSONEncoder().encode(body)
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
  
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case connectionError
    case failure
    //    var localizedMessage: String {
    //        switch self {
    //        case .connectionError:
    //            return "Bağlantı hatası"
    //        case .invalidURL:
    //            return "Bağlantı hatası"
    //        case .noData:
    //            return "Bağlantı hatası"
    //        case .decodingError:
    //            return "Bağlantı hatası"
    //        case .failure:
    //            return "Bağlantı hatası"
    //        }
    //    }
}
