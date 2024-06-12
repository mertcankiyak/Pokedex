//
//  UIView+Ext.swift
//  Pokedex
//
//  Created by MERTCAN-KIYAK on 13.05.2024.
//

import Foundation
import UIKit

extension UIView {
    func applyCustomUIViewStyle(backgroundColor: UIColor = .clear,
                          cornerRadius: CGFloat = 0,
                          shadowColor: CGColor? = nil,
                          shadowOffset: CGSize = .zero,
                          shadowOpacity: Float = 0,
                          shadowRadius: CGFloat = 0,
                          borderColor: UIColor? = nil,
                          borderWidth: CGFloat = 0) {
        self.backgroundColor = backgroundColor
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = cornerRadius > 0
        if let shadowColor = shadowColor {
            layer.shadowColor = shadowColor
            layer.shadowOffset = shadowOffset
            layer.shadowOpacity = shadowOpacity
            layer.shadowRadius = shadowRadius
        }
        if let borderColor = borderColor {
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = borderWidth
        }
    }
}
