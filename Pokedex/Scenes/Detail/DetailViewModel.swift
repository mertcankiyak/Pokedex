//
//  DetailViewModel.swift
//  Pokedex
//
//  Created by MERTCAN-KIYAK on 17.05.2024.
//

import Foundation

class DetailViewModel : DetailViewModelProtocol {
    
    var poke: PokemonResponseModelClass?
    
    init(poke: PokemonResponseModelClass? = nil) {
        self.poke = poke
    }
    
    weak var delegate: DetailViewModelDelegate?
    
    func load() {
        notify(.loading(statu: true))
        if poke != nil {
            notify(.loading(statu: false))
            notify(.completed(model: poke))
        }else{
            notify(.loading(statu: false))
            notify(.error(error: NetworkError.connectionError))
        }
        
    }
    
    private func notify(_ state: DetailState){
        delegate?.handleState(state)
    }
}
