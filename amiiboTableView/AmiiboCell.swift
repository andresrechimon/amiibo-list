//
//  AmiiboCell.swift
//  amiiboTableView
//
//  Created by Administrador on 05/12/2023.
//

import UIKit

class AmiiboCell:UITableViewCell {
    var safeArea: UILayoutGuide!
    let imageIV = CustomImageView()
    let nameLabel = UILabel()
    let gameSeriesLabel = UILabel()
    let owningCountLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        safeArea = layoutMarginsGuide
        setupOwningCountLabel()
        setupImageView()
        setupNameLabel()
        setupGameSeriesLabel()
        
    }
    
    func setupImageView(){
        addSubview(imageIV)
        
        imageIV.contentMode = .scaleAspectFit
        imageIV.translatesAutoresizingMaskIntoConstraints = false
        imageIV.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageIV.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageIV.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageIV.leadingAnchor.constraint(equalTo: owningCountLabel.trailingAnchor, constant: 10).isActive = true
    }
    
    func setupNameLabel(){
        addSubview(nameLabel)
        
        nameLabel.font = UIFont(name: "Verdana-Bold", size: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: imageIV.trailingAnchor, constant: 5).isActive = true
    }
    
    func setupGameSeriesLabel(){
        addSubview(gameSeriesLabel)
        
        gameSeriesLabel.font = UIFont(name: "Verdana", size: 14)
        gameSeriesLabel.translatesAutoresizingMaskIntoConstraints = false
        gameSeriesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        gameSeriesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
    }
    
    func setupOwningCountLabel(){
        addSubview(owningCountLabel)
        
        owningCountLabel.translatesAutoresizingMaskIntoConstraints = false
        owningCountLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        owningCountLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
    }
}
