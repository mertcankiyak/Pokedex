//
//  DetailViewController.swift
//  Pokedex
//
//  Created by MERTCAN-KIYAK on 17.05.2024.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    var poke: PokemonResponseModelClass? {
        didSet {
            backgroundView.backgroundColor = poke?.type.getPokoBgColor()
            pokeImageView.sd_setImage(with: URL(string: poke?.imageURL ?? ""))
            pokeNameLabel.text = poke?.name.capitalized
        }
    }
    
    var viewModel : DetailViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .black
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var backgroundView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()
    
    private lazy var pokeStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var pokeNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font =  UIFont.boldSystemFont(ofSize: 40.0)
        label.textColor = .white
        return label
    }()
    
    private lazy var pokeImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokeStackView.addArrangedSubview(pokeImageView)
        pokeStackView.addArrangedSubview(pokeNameLabel)
        
        backgroundView.addSubview(pokeStackView)
        view.addSubview(backgroundView)
        view.addSubview(loadingIndicator)
        setConstraint()
        viewModel.load()
        
        navigationController?.navigationBar.tintColor = .white
        
    }
}

extension DetailViewController {
    
    func setConstraint(){
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pokeStackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            pokeStackView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
        ])
    }
}


extension DetailViewController : DetailViewModelDelegate, NetworkErrorHandler {
    func handleState(_ state: DetailState) {
        switch state {
        case .loading(let statu):
            loadingIndicator.isHidden = !statu
        case .completed(let model):
            poke = model
        case .error(let error):
            presentAlert(error: error)
        }
    }
}
