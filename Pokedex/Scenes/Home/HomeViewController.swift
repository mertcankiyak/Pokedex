//
//  HomeViewController.swift
//  Pokedex
//
//  Created by MERTCAN-KIYAK on 29.04.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    var screenWidth: CGFloat!
    var pokemonList : PokemonResponseModel?
    
    private lazy var mainCollectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .black
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    var viewModel: HomeViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Pokedex"
        
        screenWidth = view.frame.width
        
        view.addSubview(mainCollectionView)
        view.addSubview(loadingIndicator)

        mainCollectionView.register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainCollectionView.collectionViewLayout = setupUICollectionViewLayout()
        setupConstraint()
        viewModel.load()
    }
    
    private func setupUICollectionViewLayout()-> UICollectionViewFlowLayout{
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: (screenWidth / 2) - 15, height: (screenWidth / 2.5))
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        return layout
    }
    
    private func setupConstraint(){
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as! PokemonCollectionViewCell
        cell.configureCell(poke: pokemonList?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(AppBuilder.makeDetail(poke: pokemonList?[indexPath.row]), animated: true)
    }
}

extension HomeViewController : HomeViewModelDelegate, NetworkErrorHandler {
    func handleState(_ state: HomeViewModelState) {
        switch state {
        case .setLoading(let isLoading):
            DispatchQueue.main.async { [weak self] in
                self?.loadingIndicator.isHidden = !isLoading
            }
        case .getAllPokemon(let pokemons):
            DispatchQueue.main.async { [weak self] in
                self?.loadingIndicator.stopAnimating()
                self?.mainCollectionView.reloadData()
            }
            self.pokemonList = pokemons
        case .error(let error):
            presentAlert(error: error)
        }
    }
    
    func navigate(to route: HomeViewRoute) {
        print("bu da navigate butonu")
    }
}
