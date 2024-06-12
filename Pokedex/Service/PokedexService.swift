//
//  PokedexService.swift
//  Pokedex
//
//  Created by MERTCAN-KIYAK on 29.04.2024.
//

import Foundation

protocol PokedexServiceProtocol {
    func getAllPokemons(completion: @escaping (Result<PokemonResponseModel, NetworkError >) -> Void)
}

struct PokedexService : PokedexServiceProtocol {
    func getAllPokemons(completion: @escaping (Result<PokemonResponseModel, NetworkError>) -> Void) {
        NetworkManager.shared.request(endpoint: .getAllPokemon) {  ( result: Result<PokemonResponseModel, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
