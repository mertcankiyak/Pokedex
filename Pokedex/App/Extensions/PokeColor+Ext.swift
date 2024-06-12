//
//  PokeColor+Ext.swift
//  Pokedex
//
//  Created by MERTCAN-KIYAK on 14.05.2024.
//

import Foundation
import UIKit

enum PokeGroupEnum : String {
    case Flying = "flying"
    case Fire = "fire"
    case Poison = "poison"
    case Water = "water"
    case Electric = "electric"
    case Base = "default"
}

extension String {
    func getPokoBgColor() -> UIColor {
        switch self {
        case PokeGroupEnum.Flying.rawValue:
            return UIColor(named: PokeGroupEnum.Flying.rawValue) ?? UIColor.systemGray5
        case PokeGroupEnum.Fire.rawValue:
            return UIColor(named: PokeGroupEnum.Fire.rawValue) ?? UIColor.systemGray5
        case PokeGroupEnum.Poison.rawValue:
            return UIColor(named: PokeGroupEnum.Poison.rawValue) ?? UIColor.systemGray5
        case PokeGroupEnum.Water.rawValue:
            return UIColor(named: PokeGroupEnum.Water.rawValue) ?? UIColor.systemGray5
        case PokeGroupEnum.Electric.rawValue:
            return UIColor(named: PokeGroupEnum.Electric.rawValue) ?? UIColor.systemGray5
        default:
            return UIColor(named: PokeGroupEnum.Base.rawValue) ?? UIColor.systemGray5
        }
    }
}
