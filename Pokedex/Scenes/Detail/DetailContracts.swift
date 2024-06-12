//
//  DetailContracts.swift
//  Pokedex
//
//  Created by MERTCAN-KIYAK on 17.05.2024.
//

import Foundation

protocol DetailViewModelProtocol {
    var delegate : DetailViewModelDelegate? {get set}
    func load()
}

protocol DetailViewModelDelegate : AnyObject {
    func handleState(_ state: DetailState)
}

enum DetailState {
    case loading(statu:Bool)
    case completed(model:PokemonResponseModelClass?)
    case error(error:NetworkError)
}
