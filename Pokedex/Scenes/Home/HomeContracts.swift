//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by MERTCAN-KIYAK on 29.04.2024.
//

import Foundation

protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? { get set }
    func load()
}

protocol HomeViewModelDelegate: AnyObject {
    func handleState(_ state: HomeViewModelState)
    func navigate(to route: HomeViewRoute)
}

enum HomeViewModelState {
    case setLoading(Bool)
    case getAllPokemon(PokemonResponseModel)
    case error(NetworkError)
}

enum HomeViewRoute {
    case pokeDetail(id: String)
}


