//
//  CustomImageView.swift
//  amiiboTableView
//
//  Created by Administrador on 06/12/2023.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    var task : URLSessionDataTask!
    let spinner = UIActivityIndicatorView(style: .gray)
    
    func loadImage(from url: URL){
        //para que no se reuse la imagen al scrollear
        image = nil
        addSpinner()
        if let task = task{
            task.cancel()
        }
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage{
            self.image = imageFromCache
            removeSpinner()
            return
        }
        //para que no se reuse la imagen al scrollear
        task = URLSession.shared.dataTask(with: url) { (data, resp, error) in
            guard let data = data, let newImage = UIImage(data: data) else {
                print("No pudo cargar imagen")
                return
            }
            imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            DispatchQueue.main.async {
                self.removeSpinner()
                self.image = newImage
            }
        }
        task.resume()
    }
    
    func addSpinner(){
        addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.startAnimating()
    }
    
    func removeSpinner(){
        spinner.removeFromSuperview()
    }
}
