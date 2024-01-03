//
//  AmiiboDetailVC.swift
//  amiiboTableView
//
//  Created by Administrador on 03/01/2024.
//

import UIKit

class AmiiboDetailVC: UIViewController {
    var amiibo: AmiiboForView?
    var safeArea:UILayoutGuide!
    let imageIV = CustomImageView()
    let nameLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        setupImage()
        setupImageData()
        setupNameLabel()
    }
    
    func setupImage(){
        view.addSubview(imageIV)
        
        imageIV.contentMode = .scaleAspectFit
        imageIV.translatesAutoresizingMaskIntoConstraints = false
        imageIV.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageIV.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50).isActive = true
        imageIV.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5).isActive = true
        imageIV.heightAnchor.constraint(equalTo: imageIV.widthAnchor).isActive = true
    }
    
    func setupImageData(){
        if let amiibo = amiibo, let url = URL(string: amiibo.imageUrl) {
            imageIV.loadImage(from: url)
            nameLabel.text = amiibo.name
        }
    }
    
    func setupNameLabel(){
        view.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: imageIV.bottomAnchor, constant: 20).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: imageIV.centerXAnchor).isActive = true
        nameLabel.textColor = .black
    }
}
