//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by MERTCAN-KIYAK on 29.04.2024.
//

import Foundation


class HomeViewModel : HomeViewModelProtocol {
    weak var delegate: HomeViewModelDelegate?
    var service : PokedexServiceProtocol?
    
    init(service: PokedexServiceProtocol){
        self.service = service
    }
    
    func load() {
        notify(.setLoading(true))
        service?.getAllPokemons(completion: { [weak self]  ( result: Result<PokemonResponseModel, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(var pokeList):
                    self?.notify(.setLoading(false))
                    pokeList.remove(at: 0)
                    self?.notify(.getAllPokemon(pokeList))
                case .failure(let error):
                    self?.notify(.error(error))
                }
            }
        })
    }
    
    private func notify(_ state: HomeViewModelState) {
        delegate?.handleState(state)
    }
}
