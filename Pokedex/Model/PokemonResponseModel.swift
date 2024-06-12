//
//  PokemonResponseModel.swift
//  Pokedex
//
//  Created by MERTCAN-KIYAK on 29.04.2024.
//

import Foundation

//// MARK: - PokemonResponseModel
//struct PokemonResponseModel  : Decodable {
//    let count: Int?
//    let next: String?
//    let previous: String?
//    let results: [ResultPoke]?
//}
//
//// MARK: - Result
//struct ResultPoke : Decodable {
//    let name: String?
//    let url: String?
//}

// MARK: - PokemonResponseModelClass
struct PokemonResponseModelClass: Codable {
    let attack, defense: Int
    let description: String
    let evolutionChain: [EvolutionChain]?
    let height, id: Int
    let imageURL: String
    let name, type: String
    let weight: Int
    let pokemonResponseModelDefense: Int?

    enum CodingKeys: String, CodingKey {
        case attack, defense, description, evolutionChain, height, id
        case imageURL = "imageUrl"
        case name, type, weight
        case pokemonResponseModelDefense = "defense:"
    }
}

// MARK: - EvolutionChain
struct EvolutionChain: Codable {
    let id, name: String
}

typealias PokemonResponseModel = [PokemonResponseModelClass?]





