//
//  AppContainer.swift
//  Pokedex
//
//  Created by MERTCAN-KIYAK on 29.04.2024.
//

import Foundation

let app = AppContainer()
let userDefaults = UserDefaults.standard

final class AppContainer {
    
    let router = AppRouter()
    let pokedexService = PokedexService()
}
