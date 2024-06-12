//
//  NetworkErrorHandler.swift
//  Pokedex
//
//  Created by MERTCAN-KIYAK on 24.05.2024.
//

import Foundation
import UIKit

protocol NetworkErrorHandler {
    func presentAlert(error: NetworkError)
}

extension NetworkErrorHandler where Self : UIViewController {
    func presentAlert(error: NetworkError){
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
