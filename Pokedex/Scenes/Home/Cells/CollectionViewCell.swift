//
//  CollectionViewCell.swift
//  Pokedex
//
//  Created by MERTCAN-KIYAK on 13.05.2024.
//

import Foundation
import UIKit
import SDWebImage


class PokemonCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PokemonCollectionViewCell"
    
    var cardBgColor : UIColor? {
        didSet{
            self.backgroundColor = cardBgColor
        }
    }
    
    var pokeTitle : String? {
        didSet{
            self.pokeTypeButton.titleLabel?.text = pokeTitle
        }
    }
    
    private lazy var pokeInfoStackView : UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private lazy var pokeIdLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font =  UIFont.boldSystemFont(ofSize: 16.0)
        label.alpha = 0.1
        return label
    }()
    
    
    private lazy var pokeTypeButton : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray6.withAlphaComponent(0.2)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)

        return button
    }()
    
    private lazy var pokeNameLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font =  UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .white
        return label
    }()
    
    private lazy var pokeBallImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.image = UIImage(named: "pokeball")
        imgView.alpha = 0.2
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(pokeBallImageView)
        addSubview(imageView)
        addSubview(pokeIdLabel)
        pokeInfoStackView.addArrangedSubview(pokeNameLabel)
        pokeInfoStackView.addArrangedSubview(pokeTypeButton)
        addSubview(pokeInfoStackView)
        
        self.applyCustomUIViewStyle(backgroundColor:  UIColor.systemGray5,
                                cornerRadius: 10,
                                shadowColor: UIColor.black.cgColor,
                                shadowOffset: CGSize(width: 0, height: 2),
                                shadowOpacity: 0.4,
                                shadowRadius: 3,
                                borderColor: UIColor.systemBackground,
                                borderWidth: 1)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: ApplicationConstants.collectionViewCellSize),
            imageView.heightAnchor.constraint(equalToConstant: ApplicationConstants.collectionViewCellSize),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            pokeBallImageView.widthAnchor.constraint(equalToConstant: 120),
            pokeBallImageView.heightAnchor.constraint(equalToConstant: 120),
            pokeBallImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 15),
            pokeBallImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 15),
            
            pokeIdLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            pokeIdLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            
            pokeInfoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            pokeInfoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            pokeInfoStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            
        ])
    }
    
    public func configureCell(poke: PokemonResponseModelClass?) {
        self.imageView.sd_setImage(with: URL(string: poke?.imageURL ?? ""))
        cardBgColor = poke?.type.getPokoBgColor()
        pokeIdLabel.text = "#00\(String(poke?.id ?? 0))"
        pokeNameLabel.text = poke?.name.capitalized
        pokeTypeButton.setTitle(poke?.type.capitalized, for: .normal)
    }
}
