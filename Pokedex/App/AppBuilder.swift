//
//  AppBuilder.swift
//  Pokedex
//
//  Created by MERTCAN-KIYAK on 29.04.2024.
//

import Foundation
import UIKit

final class AppBuilder {
    
    static func makeHome() -> HomeViewController {
        let viewController = HomeViewController()
        viewController.viewModel = HomeViewModel(service: app.pokedexService)
        return viewController
    }
    
    static func makeDetail(poke: PokemonResponseModelClass?) -> DetailViewController {
        let viewController = DetailViewController()
        viewController.viewModel = DetailViewModel(poke: poke)
        return viewController
    }
}
